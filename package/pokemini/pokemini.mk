################################################################################
#
# Pokemini Emulator
#
################################################################################

POKEMINI_VERSION = 15cc97ff70d6d9d749287ac55cb68198708564f3
POKEMINI_SITE = git://git.code.sf.net/p/pokemini/code
POKEMINI_SITE_METHOD = git
POKEMINI_DEPENDENCIES = sdl2 udev zlib

define POKEMINI_BUILD_CMDS
	 CFLAGS="$(TARGET_CFLAGS)" SLFLAGS="$(TARGET_SLFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/platform/sdl2 -f makefile
endef

define POKEMINI_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/platform/sdl2/PokeMini \
	$(TARGET_DIR)/usr/emulators/PokeMini/PokeMini
endef

$(eval $(generic-package))
