################################################################################
#
# LIBRETRO_BSNES_MERCURY
#
################################################################################
LIBRETRO_BSNES_MERCURY_VERSION = 0b37092090a9296bf5a90ff089b8d914dd9fe9a3
LIBRETRO_BSNES_MERCURY_SITE = $(call github,libretro,bsnes-mercury,$(LIBRETRO_BSNES_MERCURY_VERSION))
LIBRETRO_BSNES_MERCURY_GIT = https://github.com/libretro/bsnes-mercury.git

# Dirty hack to download submodules
define LIBRETRO_BSNES_MERCURY_EXTRACT_CMDS
	rm -rf $(@D)
	git clone --recursive $(LIBRETRO_BSNES_MERCURY_GIT) $(@D)
	touch $(@D)/.stamp_downloaded
	cd $(@D) && \
	git reset --hard $(LIBRETRO_BSNES_MERCURY_VERSION)
endef

define LIBRETRO_BSNES_MERCURY_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" LD="$(TARGET_LD)" \
	$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" -C $(@D)
endef

define LIBRETRO_BSNES_MERCURY_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/out/bsnes_mercury_accuracy_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/bsnes_mercury_accuracy_libretro.so
endef

$(eval $(generic-package))
