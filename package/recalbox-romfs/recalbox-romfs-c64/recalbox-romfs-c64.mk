################################################################################
#
# recalbox-romfs-c64
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system c64 --extension '.d64 .D64 .t64 .T64 .x64 .X64' --fullname 'Commodore 64' --platform c64 --theme c64 vice:x64:BR2_PACKAGE_VICE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_C64_SOURCE = 
RECALBOX_ROMFS_C64_SITE = 
RECALBOX_ROMFS_C64_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_C64 = c64
SYSTEM_XML_C64 = $(@D)/$(SYSTEM_NAME_C64).xml
# System rom path
SOURCE_ROMDIR_C64 = $(RECALBOX_ROMFS_C64_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_VICE),)
define CONFIGURE_MAIN_C64_START
	echo -e '<system>\n' \
	'\t<fullname>Commodore 64</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_C64)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_C64)</path>\n' \
	'\t<extension>.d64 .D64 .t64 .T64 .x64 .X64</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>c64</platform>\n' \
	'\t<theme>c64</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_C64)

endef
RECALBOX_ROMFS_C64_CONFIGURE_CMDS += $(CONFIGURE_MAIN_C64_START)


ifneq ($(BR2_PACKAGE_VICE),)
define CONFIGURE_C64_VICE_START
	echo -e '\t\t<emulator name="vice">' >> $(SYSTEM_XML_C64)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_C64)

endef
RECALBOX_ROMFS_C64_CONFIGURE_CMDS += $(CONFIGURE_C64_VICE_START)

ifeq ($(BR2_PACKAGE_VICE),y)
define CONFIGURE_C64_VICE_X64_DEF
	echo -e '\t\t\t\t<core>x64</core>' >> $(SYSTEM_XML_C64)

endef
RECALBOX_ROMFS_C64_CONFIGURE_CMDS += $(CONFIGURE_C64_VICE_X64_DEF)
endif

define CONFIGURE_C64_VICE_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_C64)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_C64)

endef
RECALBOX_ROMFS_C64_CONFIGURE_CMDS += $(CONFIGURE_C64_VICE_END)
endif



define CONFIGURE_MAIN_C64_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_C64)
	cp -R $(SOURCE_ROMDIR_C64) $(@D)
endef
RECALBOX_ROMFS_C64_CONFIGURE_CMDS += $(CONFIGURE_MAIN_C64_END)
endif

$(eval $(generic-package))
