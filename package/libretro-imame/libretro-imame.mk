################################################################################
#
# IMAME / MAME2000
#
################################################################################
LIBRETRO_IMAME_VERSION = 66891990d4e4d3fdc446b0d7147c275e757046ab
LIBRETRO_IMAME_SITE = $(call github,libretro,mame2000-libretro,$(LIBRETRO_IMAME_VERSION))

define LIBRETRO_IMAME_BUILD_CMDS
	mkdir -p $(@D)/obj_libretro_libretro/cpu
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CC="$(TARGET_CC)" -C $(@D) -f Makefile ARM=1
endef

define LIBRETRO_IMAME_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mame2000_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/imame4all_libretro.so
endef

$(eval $(generic-package))
