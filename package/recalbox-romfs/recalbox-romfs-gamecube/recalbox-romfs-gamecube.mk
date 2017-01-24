################################################################################
#
# recalbox-romfs-gamecube
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system gamecube --extension '.iso .ISO .gc .GC .gcz .GCZ' --fullname 'GameCube' --platform gc --theme gc BR2_PACKAGE_DOLPHIN_EMU

# Name the 3 vars as the package requires
RECALBOX_ROMFS_GAMECUBE_SOURCE = 
RECALBOX_ROMFS_GAMECUBE_SITE = 
RECALBOX_ROMFS_GAMECUBE_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_GAMECUBE = gamecube
SYSTEM_XML_GAMECUBE = $(@D)/$(SYSTEM_NAME_GAMECUBE).xml
# System rom path
SOURCE_ROMDIR_GAMECUBE = $(RECALBOX_ROMFS_GAMECUBE_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifeq ($(BR2_PACKAGE_DOLPHIN_EMU),y)
define CONFIGURE_GAMECUBE
	echo -e '<system>\n' \
	'\t<fullname>GameCube</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_GAMECUBE)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_GAMECUBE)</path>\n' \
	'\t<extension>.iso .ISO .gc .GC .gcz .GCZ</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>gc</platform>\n' \
	'\t<theme>gc</theme>\n' \
	'</system>' > $(SYSTEM_XML_GAMECUBE)
	cp -R $(SOURCE_ROMDIR_GAMECUBE) $(@D)
endef
RECALBOX_ROMFS_GAMECUBE_CONFIGURE_CMDS += $(CONFIGURE_GAMECUBE)
endif

$(eval $(generic-package))
