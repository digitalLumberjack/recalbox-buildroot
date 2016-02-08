################################################################################
#
# DOSBOX
#
################################################################################
LIBRETRO_DOSBOX_VERSION = 40ddb3ba03d320df15545e6829059aac3a440459
LIBRETRO_DOSBOX_SITE = $(call github,libretro,dosbox-libretro,$(LIBRETRO_DOSBOX_VERSION))

define LIBRETRO_DOSBOX_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro
endef

define LIBRETRO_DOSBOX_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/dosbox_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/dosbox_libretro.so
endef

$(eval $(generic-package))
