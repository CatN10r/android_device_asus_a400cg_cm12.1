/*
 * pack.c
 *
 * Copyright 2012 Emilio López <turl@tuxfamily.org>
 * Updated for Intel Cloverview OSIP unsigned (attribute=0x01) & cmdline override.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <string.h>
#include <unistd.h>

#ifdef __APPLE__
  #include <libkern/OSByteOrder.h>

  #define htobe16(x) OSSwapHostToBigInt16(x)
  #define htole16(x) OSSwapHostToLittleInt16(x)
  #define be16toh(x) OSSwapBigToHostInt16(x)
  #define le16toh(x) OSSwapLittleToHostInt16(x)

  #define htobe32(x) OSSwapHostToBigInt32(x)
  #define htole32(x) OSSwapHostToLittleInt32(x)
  #define be32toh(x) OSSwapBigToHostInt32(x)
  #define le32toh(x) OSSwapLittleToHostInt32(x)

  #define htobe64(x) OSSwapHostToBigInt64(x)
  #define htole64(x) OSSwapHostToLittleInt64(x)
  #define be64toh(x) OSSwapBigToHostInt64(x)
  #define le64toh(x) OSSwapLittleToHostInt64(x)
#include <sys/types.h>
#else
#include <endian.h>
#endif  /* __APPLE__ */

#include "bootheader.h"

#define ERROR(...) do { fprintf(stderr, __VA_ARGS__); return 1; } while(0)

static uint8_t calculate_checksum(struct bootheader *hdr)
{
	uint8_t sum = hdr->xor;
	uint8_t *data = (uint8_t *)hdr;
	int i;

	for (i = 0; i < HEADER_SIZE; i++) {
		sum ^= data[i];
	}

	return sum;
}

int main(int argc, char *argv[])
{
	const char *cmdline_override = NULL;
	char *origin;
	char *bzImage;
	char *ramdisk;
	char *output;
	FILE *forigin;
	FILE *foutput;
	FILE *fbzImage;
	FILE *framdisk;
	struct stat st;
	uint32_t tmp, paddings = 0, totalImageSize;
	uint32_t origImageType;
	char buf[BUFSIZ];
	size_t size;
	struct bootheader *file;
	int opt;

	while ((opt = getopt(argc, argv, "c:")) != -1) {
		switch (opt) {
		case 'c':
			cmdline_override = optarg;
			break;
		default:
			ERROR("Usage: %s [-c <cmdline>] <valid image> <bzImage> <ramdisk> <output>\n", argv[0]);
		}
	}

	if ((argc - optind) != 4)
		ERROR("Usage: %s [-c <cmdline>] <valid image> <bzImage> <ramdisk> <output>\n", argv[0]);

	origin = argv[optind];
	bzImage = argv[optind + 1];
	ramdisk = argv[optind + 2];
	output = argv[optind + 3];

	forigin = fopen(origin, "rb");
	fbzImage = fopen(bzImage, "rb");
	framdisk = fopen(ramdisk, "rb");
	foutput = fopen(output, "wb");
	if (!forigin || !fbzImage || !framdisk || !foutput)
		ERROR("ERROR: failed to open origin, kernel, ramdisk, or output image\n");

	file = calloc(1, sizeof(struct bootheader));
	if (file == NULL)
		ERROR("ERROR allocating memory\n");

	/* Read LBA0 (OSIP header + head_padding = 0x200 bytes) */
	if (fread(file, SECTOR_SIZE, 1, forigin) != 1)
		ERROR("ERROR reading OSIP LBA0 header\n");

	if (memcmp(file->magic, "$OS$", 4) != 0)
		ERROR("ERROR: origin image missing $OS$ OSIP signature\n");

	/*
	 * If origin image has even attribute (e.g. 0x00 signed stock image),
	 * skip its 0x1e0-byte VRL signature block at 0x200..0x3df before reading
	 * cmdline + sizes + padding1 + bootstubStack (0x3000 bytes).
	 */
	origImageType = le32toh(file->imageType);
	if ((origImageType & 1) == 0) {
		if (fseek(forigin, VRL_SIZE, SEEK_CUR) == -1)
			ERROR("ERROR seeking past VRL header in signed origin image\n");
	}

	if (fread(((uint8_t *)file) + SECTOR_SIZE, sizeof(struct bootheader) - SECTOR_SIZE, 1, forigin) != 1)
		ERROR("ERROR reading bootstub header from origin image\n");

	/* Mark output OSII[0].attribute = 0x01 (unsigned, no VRL header) */
	file->imageType = htole32(1);

	/* Apply optional kernel cmdline override */
	if (cmdline_override != NULL && cmdline_override[0] != '\0') {
		size_t clen = strlen(cmdline_override);
		if (clen > CMDLINE_SIZE - 2)
			clen = CMDLINE_SIZE - 2;
		memset(file->cmdline, 0, CMDLINE_SIZE);
		memcpy(file->cmdline, cmdline_override, clen);
		if (file->cmdline[clen - 1] != '\n')
			file->cmdline[clen] = '\n';
	}

	/* Figure out the bzImage size and set it */
	if (stat(bzImage, &st) == 0) {
		tmp = st.st_size;
		totalImageSize = tmp;
		file->bzImageSize = htole32(tmp);
	} else
		ERROR("ERROR reading bzImage size\n");

	totalImageSize += sizeof(struct bootheader);

	/* Figure out the ramdisk size and set it */
	if (stat(ramdisk, &st) == 0) {
		tmp = st.st_size;
		totalImageSize += tmp;
		if ((totalImageSize % SECTOR_SIZE) > 0) {
			paddings = SECTOR_SIZE - (totalImageSize % SECTOR_SIZE);
			totalImageSize += paddings;
		}
		file->initrdSize = htole32(tmp);
	} else
		ERROR("ERROR reading ramdisk\n");

	file->sectors = htole32(totalImageSize / SECTOR_SIZE - 1);
	file->xor = calculate_checksum(file);

	/* Write the patched unsigned OSIP + bootstub header */
	if (fwrite(file, sizeof(struct bootheader), 1, foutput) != 1)
		ERROR("ERROR writing image\n");

	/* Copy bzImage */
	while ((size = fread(buf, 1, BUFSIZ, fbzImage)) > 0) {
		if (fwrite(buf, 1, size, foutput) != size)
			ERROR("ERROR writing bzImage to output\n");
	}

	/* Copy ramdisk */
	while ((size = fread(buf, 1, BUFSIZ, framdisk)) > 0) {
		if (fwrite(buf, 1, size, foutput) != size)
			ERROR("ERROR writing ramdisk to output\n");
	}

	if (paddings != 0) {
		memset(buf, 0xff, paddings);
		if (fwrite(buf, paddings, 1, foutput) != 1)
			ERROR("ERROR writing sector padding to output image\n");
	}

	free(file);
	fclose(forigin);
	fclose(fbzImage);
	fclose(framdisk);
	fclose(foutput);

	return 0;
}
