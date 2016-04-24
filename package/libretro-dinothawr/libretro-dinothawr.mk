################################################################################
#
# DINOTHAWR
#
################################################################################
LIBRETRO_DINOTHAWR_VERSION = b49d96954677f53b7aac4837819c34ee0082f7fe
LIBRETRO_DINOTHAWR_SITE = $(call github,libretro,dinothawr,$(LIBRETRO_DINOTHAWR_VERSION))

define LIBRETRO_DINOTHAWR_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile
endef

define LIBRETRO_DINOTHAWR_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/dinothawr_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/dinothawr_libretro.so
endef

$(eval $(generic-package))
