################################################################################
#
# recalbox-romfs-wii
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system wii --extension '.iso .ISO .wbfs .WBFS' --fullname 'Wii' --platform wii --theme wii BR2_PACKAGE_DOLPHIN_EMU

# Name the 3 vars as the package requires
RECALBOX_ROMFS_WII_SOURCE = 
RECALBOX_ROMFS_WII_SITE = 
RECALBOX_ROMFS_WII_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_WII = wii
SYSTEM_XML_WII = $(@D)/$(SYSTEM_NAME_WII).xml
# System rom path
SOURCE_ROMDIR_WII = $(RECALBOX_ROMFS_WII_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifeq ($(BR2_PACKAGE_DOLPHIN_EMU),y)
define CONFIGURE_WII
	echo -e '<system>\n' \
	'\t<fullname>Wii</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_WII)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_WII)</path>\n' \
	'\t<extension>.iso .ISO .wbfs .WBFS</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>wii</platform>\n' \
	'\t<theme>wii</theme>\n' \
	'</system>' > $(SYSTEM_XML_WII)
	cp -R $(SOURCE_ROMDIR_WII) $(@D)
endef
RECALBOX_ROMFS_WII_CONFIGURE_CMDS += $(CONFIGURE_WII)
endif

$(eval $(generic-package))
