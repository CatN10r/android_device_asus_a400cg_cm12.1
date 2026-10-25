/*
 * unpack.c
 *
 * Copyright 2012 Emilio López <turl@tuxfamily.org>
 * Updated to unpack both signed (attribute=0x00, 0x33e0 hdr) and
 * unsigned (attribute=0x01, 0x3200 hdr) Intel OSIP boot images.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

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

int main(int argc, char *argv[])
{
	char *origin;
	char *bzImage;
	char *ramdisk;
	char *cmdline_out = NULL;
	FILE *forigin;
	FILE *fbzImage;
	FILE *framdisk;
	uint8_t magic[4];
	uint32_t imageType;
	long vrl_skip;
	long cmdline_off;
	long sizes_off;
	long payload_off;
	uint32_t bzImageLen;
	uint32_t ramdiskLen;
	uint32_t missing;
	char buf[BUFSIZ];
	size_t size;

	if (argc != 4 && argc != 5)
		ERROR("Usage: %s <image to unpack> <bzImage out> <ramdisk out> [cmdline out]\n", argv[0]);

	origin = argv[1];
	bzImage = argv[2];
	ramdisk = argv[3];
	if (argc == 5)
		cmdline_out = argv[4];

	forigin = fopen(origin, "rb");
	fbzImage = fopen(bzImage, "wb");
	framdisk = fopen(ramdisk, "wb");
	if (!forigin || !fbzImage || !framdisk)
		ERROR("ERROR: failed to open origin or output images\n");

	if (fread(magic, 1, 4, forigin) != 4 || memcmp(magic, "$OS$", 4) != 0)
		ERROR("ERROR: input image does not start with $OS$ OSIP magic\n");

	if (fseek(forigin, 0x34, SEEK_SET) == -1 || fread(&imageType, sizeof(uint32_t), 1, forigin) != 1)
		ERROR("ERROR: failed to read OSIP imageType attribute\n");
	imageType = le32toh(imageType);

	vrl_skip = ((imageType & 1) == 0) ? VRL_SIZE : 0;
	cmdline_off = CMDLINE_OFFSET_UNSIGNED + vrl_skip;
	sizes_off = CMDLINE_END_UNSIGNED + vrl_skip;
	payload_off = (long)sizeof(struct bootheader) + vrl_skip;

	if (cmdline_out != NULL) {
		char cmdbuf[CMDLINE_SIZE];
		FILE *fcmd = fopen(cmdline_out, "wb");
		if (!fcmd)
			ERROR("ERROR: failed to open cmdline output\n");
		if (fseek(forigin, cmdline_off, SEEK_SET) == -1 ||
		    fread(cmdbuf, 1, CMDLINE_SIZE, forigin) != CMDLINE_SIZE)
			ERROR("ERROR: failed to read cmdline\n");
		fwrite(cmdbuf, 1, strnlen(cmdbuf, CMDLINE_SIZE), fcmd);
		fclose(fcmd);
	}

	/* Read bzImage and ramdisk lengths */
	if (fseek(forigin, sizes_off, SEEK_SET) == -1)
		ERROR("ERROR: failed to seek on image\n");

	if (fread(&bzImageLen, sizeof(uint32_t), 1, forigin) != 1)
		ERROR("ERROR: failed to read bzImage length\n");
	bzImageLen = le32toh(bzImageLen);

	if (fread(&ramdiskLen, sizeof(uint32_t), 1, forigin) != 1)
		ERROR("ERROR: failed to read ramdisk length\n");
	ramdiskLen = le32toh(ramdiskLen);

	/* Copy bzImage */
	if (fseek(forigin, payload_off, SEEK_SET) == -1)
		ERROR("ERROR: failed to seek when copying bzImage\n");

	missing = bzImageLen;
	while (missing > 0) {
		size = fread(buf, 1, ((missing > BUFSIZ) ? BUFSIZ : missing), forigin);
		if (size == 0)
			ERROR("ERROR: unexpected EOF while reading bzImage\n");
		fwrite(buf, 1, size, fbzImage);
		missing -= size;
	}

	/* Copy ramdisk */
	if (fseek(forigin, payload_off + bzImageLen, SEEK_SET) == -1)
		ERROR("ERROR: failed to seek when copying ramdisk\n");

	missing = ramdiskLen;
	while (missing > 0) {
		size = fread(buf, 1, ((missing > BUFSIZ) ? BUFSIZ : missing), forigin);
		if (size == 0)
			ERROR("ERROR: unexpected EOF while reading ramdisk\n");
		fwrite(buf, 1, size, framdisk);
		missing -= size;
	}

	fclose(forigin);
	fclose(fbzImage);
	fclose(framdisk);

	return 0;
}
