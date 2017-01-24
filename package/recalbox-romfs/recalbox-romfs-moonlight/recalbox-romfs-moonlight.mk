################################################################################
#
# recalbox-romfs-moonlight
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system moonlight --extension '.moonlight .MOONLIGHT' --fullname 'Moonlight' --platform pc --theme moonlight BR2_PACKAGE_MOONLIGHT_EMBEDDED

# Name the 3 vars as the package requires
RECALBOX_ROMFS_MOONLIGHT_SOURCE = 
RECALBOX_ROMFS_MOONLIGHT_SITE = 
RECALBOX_ROMFS_MOONLIGHT_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_MOONLIGHT = moonlight
SYSTEM_XML_MOONLIGHT = $(@D)/$(SYSTEM_NAME_MOONLIGHT).xml
# System rom path
SOURCE_ROMDIR_MOONLIGHT = $(RECALBOX_ROMFS_MOONLIGHT_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifeq ($(BR2_PACKAGE_MOONLIGHT_EMBEDDED),y)
define CONFIGURE_MOONLIGHT
	echo -e '<system>\n' \
	'\t<fullname>Moonlight</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_MOONLIGHT)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_MOONLIGHT)</path>\n' \
	'\t<extension>.moonlight .MOONLIGHT</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>pc</platform>\n' \
	'\t<theme>moonlight</theme>\n' \
	'</system>' > $(SYSTEM_XML_MOONLIGHT)
	cp -R $(SOURCE_ROMDIR_MOONLIGHT) $(@D)
endef
RECALBOX_ROMFS_MOONLIGHT_CONFIGURE_CMDS += $(CONFIGURE_MOONLIGHT)
endif

$(eval $(generic-package))
