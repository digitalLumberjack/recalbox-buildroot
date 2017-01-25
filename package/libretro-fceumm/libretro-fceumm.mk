################################################################################
#
# FCEUMM
#
################################################################################
LIBRETRO_FCEUMM_VERSION = aaad97bbd2d90a7e1c8275b39f3e669683a61f45
LIBRETRO_FCEUMM_SITE = $(call github,libretro,libretro-fceumm,$(LIBRETRO_FCEUMM_VERSION))

ifeq ($(BR2_PACKAGE_RECALBOX_TARGET_RPI2),y)
	LIBRETRO_FCEUMM_PLATFORM=rpi2
else
	LIBRETRO_FCEUMM_PLATFORM=$(LIBRETRO_PLATFORM)
endif

define LIBRETRO_FCEUMM_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile.libretro platform="$(LIBRETRO_FCEUMM_PLATFORM)"
endef

define LIBRETRO_FCEUMM_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/fceumm_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/fceumm_libretro.so
endef

$(eval $(generic-package))
