################################################################################
#
# QUICKNES
#
################################################################################
LIBRETRO_QUICKNES_VERSION = 646fad96a5b441ff27ba43d21075236d470615ca
LIBRETRO_QUICKNES_SITE = $(call github,libretro,QuickNES_Core,$(LIBRETRO_QUICKNES_VERSION))

define LIBRETRO_QUICKNES_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_BOARD)"
endef

define LIBRETRO_QUICKNES_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/quicknes_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/quicknes_libretro.so
endef

$(eval $(generic-package))
