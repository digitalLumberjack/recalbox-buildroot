################################################################################
#
# recalbox-romfs-mastersystem
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system mastersystem --extension '.sms .SMS .zip .ZIP' --fullname 'Sega Master System / Mark III' --platform mastersystem --theme mastersystem libretro:genesisplusgx:BR2_PACKAGE_LIBRETRO_GENESISPLUSGX libretro:picodrive:BR2_PACKAGE_LIBRETRO_PICODRIVE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_MASTERSYSTEM_SOURCE = 
RECALBOX_ROMFS_MASTERSYSTEM_SITE = 
RECALBOX_ROMFS_MASTERSYSTEM_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_MASTERSYSTEM = mastersystem
SYSTEM_XML_MASTERSYSTEM = $(@D)/$(SYSTEM_NAME_MASTERSYSTEM).xml
# System rom path
SOURCE_ROMDIR_MASTERSYSTEM = $(RECALBOX_ROMFS_MASTERSYSTEM_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_MAIN_MASTERSYSTEM_START
	echo -e '<system>\n' \
	'\t<fullname>Sega Master System / Mark III</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_MASTERSYSTEM)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_MASTERSYSTEM)</path>\n' \
	'\t<extension>.sms .SMS .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>mastersystem</platform>\n' \
	'\t<theme>mastersystem</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_MASTERSYSTEM)

endef
RECALBOX_ROMFS_MASTERSYSTEM_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MASTERSYSTEM_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_MASTERSYSTEM_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_MASTERSYSTEM)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_MASTERSYSTEM)

endef
RECALBOX_ROMFS_MASTERSYSTEM_CONFIGURE_CMDS += $(CONFIGURE_MASTERSYSTEM_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX),y)
define CONFIGURE_MASTERSYSTEM_LIBRETRO_GENESISPLUSGX_DEF
	echo -e '\t\t\t\t<core>genesisplusgx</core>' >> $(SYSTEM_XML_MASTERSYSTEM)

endef
RECALBOX_ROMFS_MASTERSYSTEM_CONFIGURE_CMDS += $(CONFIGURE_MASTERSYSTEM_LIBRETRO_GENESISPLUSGX_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_PICODRIVE),y)
define CONFIGURE_MASTERSYSTEM_LIBRETRO_PICODRIVE_DEF
	echo -e '\t\t\t\t<core>picodrive</core>' >> $(SYSTEM_XML_MASTERSYSTEM)

endef
RECALBOX_ROMFS_MASTERSYSTEM_CONFIGURE_CMDS += $(CONFIGURE_MASTERSYSTEM_LIBRETRO_PICODRIVE_DEF)
endif

define CONFIGURE_MASTERSYSTEM_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_MASTERSYSTEM)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_MASTERSYSTEM)

endef
RECALBOX_ROMFS_MASTERSYSTEM_CONFIGURE_CMDS += $(CONFIGURE_MASTERSYSTEM_LIBRETRO_END)
endif



define CONFIGURE_MAIN_MASTERSYSTEM_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_MASTERSYSTEM)
	cp -R $(SOURCE_ROMDIR_MASTERSYSTEM) $(@D)
endef
RECALBOX_ROMFS_MASTERSYSTEM_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MASTERSYSTEM_END)
endif

$(eval $(generic-package))
