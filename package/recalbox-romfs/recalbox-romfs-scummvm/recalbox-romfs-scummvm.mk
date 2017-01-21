################################################################################
#
# recalbox-romfs-scummvm
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system scummvm --extension '.scummvm' --fullname 'ScummVM' --platform scummvm --theme scummvm BR2_PACKAGE_SCUMMVM

# Name the 3 vars as the package requires
RECALBOX_ROMFS_SCUMMVM_SOURCE = 
RECALBOX_ROMFS_SCUMMVM_SITE = 
RECALBOX_ROMFS_SCUMMVM_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_SCUMMVM = scummvm
SYSTEM_XML_SCUMMVM = $(@D)/$(SYSTEM_NAME_SCUMMVM).xml
# System rom path
SOURCE_ROMDIR_SCUMMVM = $(RECALBOX_ROMFS_SCUMMVM_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifeq ($(BR2_PACKAGE_SCUMMVM),y)
define CONFIGURE_SCUMMVM
	echo -e '<system>\n' \
	'\t<fullname>ScummVM</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_SCUMMVM)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_SCUMMVM)</path>\n' \
	'\t<extension>.scummvm</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>scummvm</platform>\n' \
	'\t<theme>scummvm</theme>\n' \
	'</system>' > $(SYSTEM_XML_SCUMMVM)
	cp -R $(SOURCE_ROMDIR_SCUMMVM) $(@D)
endef
RECALBOX_ROMFS_SCUMMVM_CONFIGURE_CMDS += $(CONFIGURE_SCUMMVM)
endif

$(eval $(generic-package))
