# This is a custom bootimage target file to be used on CM
# Set these variables on your BoardConfig.mk
#
# DEVICE_BASE_BOOT_IMAGE := path/to/stuff/existingboot.img
# DEVICE_BASE_RECOVERY_IMAGE := path/to/stuff/existingrecovery.img
# BOARD_CUSTOM_BOOTIMG_MK := path/to/intel-boot-tools/boot.mk
#

INTEL_PACK := $(HOST_OUT_EXECUTABLES)/pack_intel$(HOST_EXECUTABLE_SUFFIX)
BASE_BOOT_IMAGE := $(firstword $(DEVICE_BASE_BOOT_IMAGE))
BASE_RECOVERY_IMAGE := $(if $(DEVICE_BASE_RECOVERY_IMAGE),$(firstword $(DEVICE_BASE_RECOVERY_IMAGE)),$(BASE_BOOT_IMAGE))

$(INSTALLED_RECOVERYIMAGE_TARGET): $(recovery_ramdisk) \
		$(recovery_kernel) \
		$(INTEL_PACK) \
		$(MKBOOTFS) | $(MINIGZIP)
	$(call pretty,"Target recovery image: $@")
	$(hide) mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/lib/modules
	$(hide) for ko in pnwdisp.ko pvrsgx.ko rmi4.ko; do \
		if [ -f "$(TARGET_OUT)/lib/modules/$$ko" ]; then \
			cp -f "$(TARGET_OUT)/lib/modules/$$ko" "$(TARGET_RECOVERY_ROOT_OUT)/lib/modules/"; \
		fi; \
	done
	$(hide) $(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) | $(MINIGZIP) > $(recovery_ramdisk)
	$(INTEL_PACK) -c "$(BOARD_KERNEL_CMDLINE)" $(BASE_RECOVERY_IMAGE) $(recovery_kernel) $(recovery_ramdisk) $@
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)

$(INSTALLED_BOOTIMAGE_TARGET): $(INSTALLED_RAMDISK_TARGET) \
		$(INSTALLED_KERNEL_TARGET) \
		$(INTEL_PACK) \
		$(MKBOOTFS) | $(MINIGZIP)
	$(call pretty,"Target boot image: $@")
	$(hide) mkdir -p $(TARGET_ROOT_OUT)/lib/modules
	$(hide) if ls $(TARGET_OUT)/lib/modules/*.ko >/dev/null 2>&1; then \
		cp -f $(TARGET_OUT)/lib/modules/*.ko $(TARGET_ROOT_OUT)/lib/modules/; \
	fi
	$(hide) $(MKBOOTFS) $(TARGET_ROOT_OUT) | $(MINIGZIP) > $(INSTALLED_RAMDISK_TARGET)
	$(INTEL_PACK) -c "$(BOARD_KERNEL_CMDLINE)" $(BASE_BOOT_IMAGE) $(INSTALLED_KERNEL_TARGET) $(INSTALLED_RAMDISK_TARGET) $@
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
