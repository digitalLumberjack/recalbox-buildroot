################################################################################
#
# recalbox-romfs-sg1000
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system sg1000 --extension '.sg .SG .zip .ZIP' --fullname 'Sega SG1000' --platform sg1000 --theme sg1000 libretro:genesisplusgx:BR2_PACKAGE_LIBRETRO_GENESISPLUSGX libretro:picodrive:BR2_PACKAGE_LIBRETRO_PICODRIVE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_SG1000_SOURCE = 
RECALBOX_ROMFS_SG1000_SITE = 
RECALBOX_ROMFS_SG1000_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_SG1000 = sg1000
SYSTEM_XML_SG1000 = $(@D)/$(SYSTEM_NAME_SG1000).xml
# System rom path
SOURCE_ROMDIR_SG1000 = $(RECALBOX_ROMFS_SG1000_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_MAIN_SG1000_START
	echo -e '<system>\n' \
	'\t<fullname>Sega SG1000</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_SG1000)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_SG1000)</path>\n' \
	'\t<extension>.sg .SG .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>sg1000</platform>\n' \
	'\t<theme>sg1000</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_SG1000)

endef
RECALBOX_ROMFS_SG1000_CONFIGURE_CMDS += $(CONFIGURE_MAIN_SG1000_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_SG1000_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_SG1000)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_SG1000)

endef
RECALBOX_ROMFS_SG1000_CONFIGURE_CMDS += $(CONFIGURE_SG1000_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX),y)
define CONFIGURE_SG1000_LIBRETRO_GENESISPLUSGX_DEF
	echo -e '\t\t\t\t<core>genesisplusgx</core>' >> $(SYSTEM_XML_SG1000)

endef
RECALBOX_ROMFS_SG1000_CONFIGURE_CMDS += $(CONFIGURE_SG1000_LIBRETRO_GENESISPLUSGX_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_PICODRIVE),y)
define CONFIGURE_SG1000_LIBRETRO_PICODRIVE_DEF
	echo -e '\t\t\t\t<core>picodrive</core>' >> $(SYSTEM_XML_SG1000)

endef
RECALBOX_ROMFS_SG1000_CONFIGURE_CMDS += $(CONFIGURE_SG1000_LIBRETRO_PICODRIVE_DEF)
endif

define CONFIGURE_SG1000_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_SG1000)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_SG1000)

endef
RECALBOX_ROMFS_SG1000_CONFIGURE_CMDS += $(CONFIGURE_SG1000_LIBRETRO_END)
endif



define CONFIGURE_MAIN_SG1000_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_SG1000)
	cp -R $(SOURCE_ROMDIR_SG1000) $(@D)
endef
RECALBOX_ROMFS_SG1000_CONFIGURE_CMDS += $(CONFIGURE_MAIN_SG1000_END)
endif

$(eval $(generic-package))
