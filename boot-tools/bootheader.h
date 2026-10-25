#include <stdint.h>

#ifndef __BOOTHEADER__
#define __BOOTHEADER__

#define MAGIC_SIZE						(7)
#define ID_SIZE							(0x28)
#define HEADER_SIZE						(MAGIC_SIZE + 0x1 + ID_SIZE + 0x4 + 0x4)

#define HEAD_PADDING						(0x1c8)
#define VRL_SIZE						(0x1e0)

#define CMDLINE_SIZE						(0x400)
#define CMDLINE_OFFSET_UNSIGNED					(HEADER_SIZE + HEAD_PADDING)
#define CMDLINE_END_UNSIGNED					(CMDLINE_OFFSET_UNSIGNED + CMDLINE_SIZE)
// uint32_t * 4 = 0x10, total: 0x410

#define PADDING1_SIZE						(0xbf0) // (0x1000 - 0x410)
#define BOOTSTUBSTACK_SIZE					(0x2000)

#define SECTOR_SIZE						(0x200)	// 512

/*
 * Unsigned OSIP + bootstub header layout (0x3200 bytes total):
 *   0x0000..0x0037 : OSIP header + OSII[0] descriptor (imageType = 1 => unsigned)
 *   0x0038..0x01ff : LBA0 padding + 0x55AA signature
 *   0x0200..0x05ff : Kernel cmdline (1024 bytes)
 *   0x0600..0x060f : bzImageSize, initrdSize, SPIUARTSuppression, SPIType
 *   0x0610..0x11ff : Zero padding up to +0x1000 from LBA1
 *   0x1200..0x31ff : bootstub code/stack (loaded at 0x01101000 = entry_point)
 *
 * Note: Signed stock images (imageType = 0) insert a 0x1e0-byte VRL signature
 * block at 0x0200..0x03df before cmdline (making total header 0x33e0 bytes).
 */
struct bootheader {
	uint8_t magic[MAGIC_SIZE];			// $OS$\0\0\1
	uint8_t xor;					// XOR of first 56 bytes (so 56-byte XOR == 0)
	uint8_t id[ID_SIZE];				// OSIP rev/pointers + OSII[0] load/entry addrs
	uint32_t sectors;				// Total sectors after LBA0 (totalSize/512 - 1)
	uint32_t imageType;				// OSII[0].attribute: 0 = signed (VRL), 1 = unsigned

	uint8_t head_padding[HEAD_PADDING];		// LBA0 padding ending with 00 00 55 AA
	char cmdline[CMDLINE_SIZE];
	uint32_t bzImageSize;
	uint32_t initrdSize;
	uint32_t SPIUARTSuppression;
	uint32_t SPIType;
	uint8_t padding1[PADDING1_SIZE];
	uint8_t bootstubStack[BOOTSTUBSTACK_SIZE];
};

/* Sanity check for unsigned header struct size (0x3200 = 12800 bytes) */
typedef char z[(sizeof(struct bootheader) == HEADER_SIZE + HEAD_PADDING + 0x3000) ? 1 : -1];

#endif
