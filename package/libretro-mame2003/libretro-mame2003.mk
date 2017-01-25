################################################################################
#
# MAME2003
#
################################################################################
LIBRETRO_MAME2003_VERSION = 686bda7f8daa95f524dd86ca0d81b3176e3ce2d3
LIBRETRO_MAME2003_SITE = $(call github,libretro,mame2003-libretro,$(LIBRETRO_MAME2003_VERSION))

define LIBRETRO_MAME2003_BUILD_CMDS
	mkdir -p $(@D)/obj/mame/cpu/ccpu
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_CC)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_BOARD)"
endef

define LIBRETRO_MAME2003_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mame2003_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mame078_libretro.so
endef

$(eval $(generic-package))
