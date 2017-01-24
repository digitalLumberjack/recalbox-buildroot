################################################################################
#
# recalbox-romfs-dos
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system dos --extension '.pc .PC .dos .DOS' --fullname 'Dos (x86)' --platform pc --theme pc BR2_PACKAGE_DOSBOX

# Name the 3 vars as the package requires
RECALBOX_ROMFS_DOS_SOURCE = 
RECALBOX_ROMFS_DOS_SITE = 
RECALBOX_ROMFS_DOS_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_DOS = dos
SYSTEM_XML_DOS = $(@D)/$(SYSTEM_NAME_DOS).xml
# System rom path
SOURCE_ROMDIR_DOS = $(RECALBOX_ROMFS_DOS_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifeq ($(BR2_PACKAGE_DOSBOX),y)
define CONFIGURE_DOS
	echo -e '<system>\n' \
	'\t<fullname>Dos (x86)</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_DOS)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_DOS)</path>\n' \
	'\t<extension>.pc .PC .dos .DOS</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>pc</platform>\n' \
	'\t<theme>pc</theme>\n' \
	'</system>' > $(SYSTEM_XML_DOS)
	cp -R $(SOURCE_ROMDIR_DOS) $(@D)
endef
RECALBOX_ROMFS_DOS_CONFIGURE_CMDS += $(CONFIGURE_DOS)
endif

$(eval $(generic-package))
