################################################################################
#
# TYRQUAKE - Quake 1 Emulator
#
################################################################################
LIBRETRO_TYRQUAKE_VERSION = 2fc80d0e508bae692ad09537fc30fd5eb84e2bdc
LIBRETRO_TYRQUAKE_SITE = $(call github,libretro,tyrquake,$(LIBRETRO_TYRQUAKE_VERSION))

define LIBRETRO_TYRQUAKE_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_PLATFORM)"
endef

define LIBRETRO_TYRQUAKE_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/tyrquake_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/tyrquake_libretro.so
endef

$(eval $(generic-package))
