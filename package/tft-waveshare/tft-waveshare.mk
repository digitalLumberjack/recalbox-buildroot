################################################################################
#
# tft-waveshare
#
################################################################################

TFT_WAVESHARE_VERSION = cdb977724a70578c661d5a3d5ab221237310f6b0
#TFT_WAVESHARE_SITE = https://github.com/swkim01/waveshare-dtoverlays.git
TFT_WAVESHARE_SITE = $(call github,swkim01,waveshare-dtoverlays,$(TFT_WAVESHARE_VERSION))
TFT_WAVESHARE_PI_DEPENDENCIES += rpi-firmware

define TFT_WAVESHARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/waveshare32b-overlay.dtb $(BINARIES_DIR)/rpi-firmware/overlays/waveshare32b.dtbo
	$(INSTALL) -D -m 0644 $(@D)/waveshare32b-overlay.dts $(BINARIES_DIR)/rpi-firmware/overlays/waveshare32b.dts
	$(INSTALL) -D -m 0644 $(@D)/waveshare35a-overlay.dtb $(BINARIES_DIR)/rpi-firmware/overlays/waveshare35a.dtbo
	$(INSTALL) -D -m 0644 $(@D)/waveshare35a-overlay.dts $(BINARIES_DIR)/rpi-firmware/overlays/waveshare35a.dts
endef

$(eval $(generic-package))
