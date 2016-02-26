################################################################################
#
# 2048
#
################################################################################
LIBRETRO_2048_VERSION = bcf98b6ad28c96b12f1888456d1ab58cd4c5a826
LIBRETRO_2048_SITE = $(call github,libretro,libretro-2048,$(LIBRETRO_2048_VERSION))

define LIBRETRO_2048_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro
endef

define LIBRETRO_2048_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/2048_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/2048_libretro.so
endef

$(eval $(generic-package))
