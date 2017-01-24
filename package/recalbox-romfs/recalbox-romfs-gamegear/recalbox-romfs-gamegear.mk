################################################################################
#
# recalbox-romfs-gamegear
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system gamegear --extension '.gg .GG .zip .ZIP' --fullname 'Sega Game Gear' --platform gamegear --theme gamegear libretro:genesisplusgx:BR2_PACKAGE_LIBRETRO_GENESISPLUSGX libretro:picodrive:BR2_PACKAGE_LIBRETRO_PICODRIVE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_GAMEGEAR_SOURCE = 
RECALBOX_ROMFS_GAMEGEAR_SITE = 
RECALBOX_ROMFS_GAMEGEAR_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_GAMEGEAR = gamegear
SYSTEM_XML_GAMEGEAR = $(@D)/$(SYSTEM_NAME_GAMEGEAR).xml
# System rom path
SOURCE_ROMDIR_GAMEGEAR = $(RECALBOX_ROMFS_GAMEGEAR_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_MAIN_GAMEGEAR_START
	echo -e '<system>\n' \
	'\t<fullname>Sega Game Gear</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_GAMEGEAR)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_GAMEGEAR)</path>\n' \
	'\t<extension>.gg .GG .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>gamegear</platform>\n' \
	'\t<theme>gamegear</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_GAMEGEAR)

endef
RECALBOX_ROMFS_GAMEGEAR_CONFIGURE_CMDS += $(CONFIGURE_MAIN_GAMEGEAR_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_GAMEGEAR_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_GAMEGEAR)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_GAMEGEAR)

endef
RECALBOX_ROMFS_GAMEGEAR_CONFIGURE_CMDS += $(CONFIGURE_GAMEGEAR_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX),y)
define CONFIGURE_GAMEGEAR_LIBRETRO_GENESISPLUSGX_DEF
	echo -e '\t\t\t\t<core>genesisplusgx</core>' >> $(SYSTEM_XML_GAMEGEAR)

endef
RECALBOX_ROMFS_GAMEGEAR_CONFIGURE_CMDS += $(CONFIGURE_GAMEGEAR_LIBRETRO_GENESISPLUSGX_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_PICODRIVE),y)
define CONFIGURE_GAMEGEAR_LIBRETRO_PICODRIVE_DEF
	echo -e '\t\t\t\t<core>picodrive</core>' >> $(SYSTEM_XML_GAMEGEAR)

endef
RECALBOX_ROMFS_GAMEGEAR_CONFIGURE_CMDS += $(CONFIGURE_GAMEGEAR_LIBRETRO_PICODRIVE_DEF)
endif

define CONFIGURE_GAMEGEAR_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_GAMEGEAR)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_GAMEGEAR)

endef
RECALBOX_ROMFS_GAMEGEAR_CONFIGURE_CMDS += $(CONFIGURE_GAMEGEAR_LIBRETRO_END)
endif



define CONFIGURE_MAIN_GAMEGEAR_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_GAMEGEAR)
	cp -R $(SOURCE_ROMDIR_GAMEGEAR) $(@D)
endef
RECALBOX_ROMFS_GAMEGEAR_CONFIGURE_CMDS += $(CONFIGURE_MAIN_GAMEGEAR_END)
endif

$(eval $(generic-package))
