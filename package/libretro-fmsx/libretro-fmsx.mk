################################################################################
#
# FMSX
#
################################################################################
LIBRETRO_FMSX_VERSION = 9bfae24eb96ef20872b467e3d1a26036df68835f
LIBRETRO_FMSX_SITE = $(call github,libretro,fmsx-libretro,$(LIBRETRO_FMSX_VERSION))

define LIBRETRO_FMSX_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" \
        $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" -C $(@D) platform="$(LIBRETRO_BOARD)"
endef

define LIBRETRO_FMSX_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/fmsx_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/fmsx_libretro.so
endef

$(eval $(generic-package))
