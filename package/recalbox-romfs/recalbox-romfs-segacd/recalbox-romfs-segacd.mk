################################################################################
#
# recalbox-romfs-segacd
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system segacd --extension '.cue .CUE .iso .ISO' --fullname 'Sega CD' --platform segacd --theme segacd libretro:genesisplusgx:BR2_PACKAGE_LIBRETRO_GENESISPLUSGX libretro:picodrive:BR2_PACKAGE_LIBRETRO_PICODRIVE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_SEGACD_SOURCE = 
RECALBOX_ROMFS_SEGACD_SITE = 
RECALBOX_ROMFS_SEGACD_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_SEGACD = segacd
SYSTEM_XML_SEGACD = $(@D)/$(SYSTEM_NAME_SEGACD).xml
# System rom path
SOURCE_ROMDIR_SEGACD = $(RECALBOX_ROMFS_SEGACD_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_MAIN_SEGACD_START
	echo -e '<system>\n' \
	'\t<fullname>Sega CD</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_SEGACD)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_SEGACD)</path>\n' \
	'\t<extension>.cue .CUE .iso .ISO</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>segacd</platform>\n' \
	'\t<theme>segacd</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_SEGACD)

endef
RECALBOX_ROMFS_SEGACD_CONFIGURE_CMDS += $(CONFIGURE_MAIN_SEGACD_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_SEGACD_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_SEGACD)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_SEGACD)

endef
RECALBOX_ROMFS_SEGACD_CONFIGURE_CMDS += $(CONFIGURE_SEGACD_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX),y)
define CONFIGURE_SEGACD_LIBRETRO_GENESISPLUSGX_DEF
	echo -e '\t\t\t\t<core>genesisplusgx</core>' >> $(SYSTEM_XML_SEGACD)

endef
RECALBOX_ROMFS_SEGACD_CONFIGURE_CMDS += $(CONFIGURE_SEGACD_LIBRETRO_GENESISPLUSGX_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_PICODRIVE),y)
define CONFIGURE_SEGACD_LIBRETRO_PICODRIVE_DEF
	echo -e '\t\t\t\t<core>picodrive</core>' >> $(SYSTEM_XML_SEGACD)

endef
RECALBOX_ROMFS_SEGACD_CONFIGURE_CMDS += $(CONFIGURE_SEGACD_LIBRETRO_PICODRIVE_DEF)
endif

define CONFIGURE_SEGACD_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_SEGACD)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_SEGACD)

endef
RECALBOX_ROMFS_SEGACD_CONFIGURE_CMDS += $(CONFIGURE_SEGACD_LIBRETRO_END)
endif



define CONFIGURE_MAIN_SEGACD_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_SEGACD)
	cp -R $(SOURCE_ROMDIR_SEGACD) $(@D)
endef
RECALBOX_ROMFS_SEGACD_CONFIGURE_CMDS += $(CONFIGURE_MAIN_SEGACD_END)
endif

$(eval $(generic-package))
