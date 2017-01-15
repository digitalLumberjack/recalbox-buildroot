################################################################################
#
# PROSYSTEM
#
################################################################################
LIBRETRO_PROSYSTEM_VERSION = b6f7c1bf776cc116105708d5ce672ac2df79a741
LIBRETRO_PROSYSTEM_SITE = $(call github,libretro,prosystem-libretro,$(LIBRETRO_PROSYSTEM_VERSION))

define LIBRETRO_PROSYSTEM_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_BOARD)"
endef

define LIBRETRO_PROSYSTEM_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/prosystem_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/prosystem_libretro.so
endef

$(eval $(generic-package))
