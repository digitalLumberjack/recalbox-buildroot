################################################################################
#
# recalbox-romfs-zx81
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system zx81 --extension '.tzx .TZX .p .P .zip .ZIP' --fullname 'ZX81' --platform zx81 --theme zx81 libretro:81:BR2_PACKAGE_LIBRETRO_81

# Name the 3 vars as the package requires
RECALBOX_ROMFS_ZX81_SOURCE = 
RECALBOX_ROMFS_ZX81_SITE = 
RECALBOX_ROMFS_ZX81_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_ZX81 = zx81
SYSTEM_XML_ZX81 = $(@D)/$(SYSTEM_NAME_ZX81).xml
# System rom path
SOURCE_ROMDIR_ZX81 = $(RECALBOX_ROMFS_ZX81_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_81),)
define CONFIGURE_MAIN_ZX81_START
	echo -e '<system>\n' \
	'\t<fullname>ZX81</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_ZX81)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_ZX81)</path>\n' \
	'\t<extension>.tzx .TZX .p .P .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>zx81</platform>\n' \
	'\t<theme>zx81</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_ZX81)

endef
RECALBOX_ROMFS_ZX81_CONFIGURE_CMDS += $(CONFIGURE_MAIN_ZX81_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_81),)
define CONFIGURE_ZX81_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_ZX81)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_ZX81)

endef
RECALBOX_ROMFS_ZX81_CONFIGURE_CMDS += $(CONFIGURE_ZX81_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_81),y)
define CONFIGURE_ZX81_LIBRETRO_81_DEF
	echo -e '\t\t\t\t<core>81</core>' >> $(SYSTEM_XML_ZX81)

endef
RECALBOX_ROMFS_ZX81_CONFIGURE_CMDS += $(CONFIGURE_ZX81_LIBRETRO_81_DEF)
endif

define CONFIGURE_ZX81_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_ZX81)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_ZX81)

endef
RECALBOX_ROMFS_ZX81_CONFIGURE_CMDS += $(CONFIGURE_ZX81_LIBRETRO_END)
endif



define CONFIGURE_MAIN_ZX81_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_ZX81)
	cp -R $(SOURCE_ROMDIR_ZX81) $(@D)
endef
RECALBOX_ROMFS_ZX81_CONFIGURE_CMDS += $(CONFIGURE_MAIN_ZX81_END)
endif

$(eval $(generic-package))
