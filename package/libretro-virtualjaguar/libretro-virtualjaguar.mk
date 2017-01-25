################################################################################
#
# VIRTUALJAGUAR
#
################################################################################
LIBRETRO_VIRTUALJAGUAR_VERSION = 041474572defae9eb163fc1913431f6b5e713fa4
LIBRETRO_VIRTUALJAGUAR_SITE = $(call github,libretro,virtualjaguar-libretro,$(LIBRETRO_VIRTUALJAGUAR_VERSION))

define LIBRETRO_VIRTUALJAGUAR_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_PLATFORM)"
endef

define LIBRETRO_VIRTUALJAGUAR_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/virtualjaguar_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/virtualjaguar_libretro.so
endef

$(eval $(generic-package))
