################################################################################
#
# FBA
#
################################################################################
LIBRETRO_FBA_VERSION = 82438165f12d490cbc053c301eb863a14d2e16dc
LIBRETRO_FBA_SITE = $(call github,libretro,fbalpha,$(LIBRETRO_FBA_VERSION))

define LIBRETRO_FBA_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f makefile.libretro platform="$(LIBRETRO_BOARD)"
endef

define LIBRETRO_FBA_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/fbalpha_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/fba_libretro.so
endef

$(eval $(generic-package))
