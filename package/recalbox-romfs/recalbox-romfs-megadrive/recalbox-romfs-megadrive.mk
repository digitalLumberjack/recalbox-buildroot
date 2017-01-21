################################################################################
#
# recalbox-romfs-megadrive
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system megadrive --extension '.md .MD .bin .BIN .zip .ZIP .gen .GEN .smd .SMD' --fullname 'Sega Megadrive' --platform megadrive --theme megadrive libretro:genesisplusgx:BR2_PACKAGE_LIBRETRO_GENESISPLUSGX libretro:picodrive:BR2_PACKAGE_LIBRETRO_PICODRIVE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_MEGADRIVE_SOURCE = 
RECALBOX_ROMFS_MEGADRIVE_SITE = 
RECALBOX_ROMFS_MEGADRIVE_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_MEGADRIVE = megadrive
SYSTEM_XML_MEGADRIVE = $(@D)/$(SYSTEM_NAME_MEGADRIVE).xml
# System rom path
SOURCE_ROMDIR_MEGADRIVE = $(RECALBOX_ROMFS_MEGADRIVE_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_MAIN_MEGADRIVE_START
	echo -e '<system>\n' \
	'\t<fullname>Sega Megadrive</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_MEGADRIVE)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_MEGADRIVE)</path>\n' \
	'\t<extension>.md .MD .bin .BIN .zip .ZIP .gen .GEN .smd .SMD</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>megadrive</platform>\n' \
	'\t<theme>megadrive</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_MEGADRIVE)

endef
RECALBOX_ROMFS_MEGADRIVE_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MEGADRIVE_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_MEGADRIVE_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_MEGADRIVE)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_MEGADRIVE)

endef
RECALBOX_ROMFS_MEGADRIVE_CONFIGURE_CMDS += $(CONFIGURE_MEGADRIVE_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX),y)
define CONFIGURE_MEGADRIVE_LIBRETRO_GENESISPLUSGX_DEF
	echo -e '\t\t\t\t<core>genesisplusgx</core>' >> $(SYSTEM_XML_MEGADRIVE)

endef
RECALBOX_ROMFS_MEGADRIVE_CONFIGURE_CMDS += $(CONFIGURE_MEGADRIVE_LIBRETRO_GENESISPLUSGX_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_PICODRIVE),y)
define CONFIGURE_MEGADRIVE_LIBRETRO_PICODRIVE_DEF
	echo -e '\t\t\t\t<core>picodrive</core>' >> $(SYSTEM_XML_MEGADRIVE)

endef
RECALBOX_ROMFS_MEGADRIVE_CONFIGURE_CMDS += $(CONFIGURE_MEGADRIVE_LIBRETRO_PICODRIVE_DEF)
endif

define CONFIGURE_MEGADRIVE_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_MEGADRIVE)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_MEGADRIVE)

endef
RECALBOX_ROMFS_MEGADRIVE_CONFIGURE_CMDS += $(CONFIGURE_MEGADRIVE_LIBRETRO_END)
endif



define CONFIGURE_MAIN_MEGADRIVE_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_MEGADRIVE)
	cp -R $(SOURCE_ROMDIR_MEGADRIVE) $(@D)
endef
RECALBOX_ROMFS_MEGADRIVE_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MEGADRIVE_END)
endif

$(eval $(generic-package))
