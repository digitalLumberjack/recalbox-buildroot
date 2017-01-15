################################################################################
#
# METEOR
#
################################################################################
LIBRETRO_METEOR_VERSION = a309da72494dc6c0c4db2bead873913ac3e0a815
LIBRETRO_METEOR_SITE = $(call github,libretro,meteor-libretro,$(LIBRETRO_METEOR_VERSION))


define LIBRETRO_METEOR_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" \
	$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" AR="$(TARGET_AR)" RANLIB="$(TARGET_RANLIB)" -C $(@D)/libretro platform="$(LIBRETRO_BOARD)"
endef

define LIBRETRO_METEOR_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/libretro/meteor_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/meteor_libretro.so
endef

$(eval $(generic-package))
