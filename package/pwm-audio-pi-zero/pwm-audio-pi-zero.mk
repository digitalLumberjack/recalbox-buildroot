################################################################################
#
# pwm-audio-pi-zero
#
################################################################################

PWM_AUDIO_PI_ZERO_VERSION = 8bc1e626130f76667ca08bd074f992e366883d6a
PWM_AUDIO_PI_ZERO_SITE = $(call github,ian57,pwm-audio-pizero,$(PWM_AUDIO_PI_ZERO_VERSION))
PWM_AUDIO_PI_ZERO_DEPENDENCIES += rpi-firmware

define PWM_AUDIO_PI_ZERO_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/pwm-audio-pi-zero-overlay.dtbo $(BINARIES_DIR)/rpi-firmware/overlays/pwm-audio-pi-zero.dtbo
	$(INSTALL) -D -m 0644 $(@D)/pwm-audio-pi-zero-overlay.dts $(BINARIES_DIR)/rpi-firmware/overlays/pwm-audio-pi-zero.dts
endef

$(eval $(generic-package))
