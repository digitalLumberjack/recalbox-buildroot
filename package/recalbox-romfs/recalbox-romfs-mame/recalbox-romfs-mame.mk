################################################################################
#
# recalbox-romfs-mame
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system mame --extension '.zip .ZIP' --fullname 'Mame' --platform mame --theme mame libretro:mame078:BR2_PACKAGE_LIBRETRO_MAME2003 libretro:imame4all:BR2_PACKAGE_LIBRETRO_IMAME advancemame:advancemame:BR2_PACKAGE_ADVANCEMAME

# Name the 3 vars as the package requires
RECALBOX_ROMFS_MAME_SOURCE = 
RECALBOX_ROMFS_MAME_SITE = 
RECALBOX_ROMFS_MAME_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_MAME = mame
SYSTEM_XML_MAME = $(@D)/$(SYSTEM_NAME_MAME).xml
# System rom path
SOURCE_ROMDIR_MAME = $(RECALBOX_ROMFS_MAME_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_MAME2003)$(BR2_PACKAGE_LIBRETRO_IMAME)$(BR2_PACKAGE_ADVANCEMAME),)
define CONFIGURE_MAIN_MAME_START
	echo -e '<system>\n' \
	'\t<fullname>Mame</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_MAME)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_MAME)</path>\n' \
	'\t<extension>.zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>mame</platform>\n' \
	'\t<theme>mame</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_MAME)

endef
RECALBOX_ROMFS_MAME_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MAME_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_MAME2003)$(BR2_PACKAGE_LIBRETRO_IMAME)$(BR2_PACKAGE_ADVANCEMAME),)
define CONFIGURE_MAME_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_MAME)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_MAME)

endef
RECALBOX_ROMFS_MAME_CONFIGURE_CMDS += $(CONFIGURE_MAME_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_MAME2003),y)
define CONFIGURE_MAME_LIBRETRO_MAME078_DEF
	echo -e '\t\t\t\t<core>mame078</core>' >> $(SYSTEM_XML_MAME)

endef
RECALBOX_ROMFS_MAME_CONFIGURE_CMDS += $(CONFIGURE_MAME_LIBRETRO_MAME078_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_IMAME),y)
define CONFIGURE_MAME_LIBRETRO_IMAME4ALL_DEF
	echo -e '\t\t\t\t<core>imame4all</core>' >> $(SYSTEM_XML_MAME)

endef
RECALBOX_ROMFS_MAME_CONFIGURE_CMDS += $(CONFIGURE_MAME_LIBRETRO_IMAME4ALL_DEF)
endif

define CONFIGURE_MAME_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_MAME)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_MAME)

endef
RECALBOX_ROMFS_MAME_CONFIGURE_CMDS += $(CONFIGURE_MAME_LIBRETRO_END)
endif

ifneq ($(BR2_PACKAGE_LIBRETRO_MAME2003)$(BR2_PACKAGE_LIBRETRO_IMAME)$(BR2_PACKAGE_ADVANCEMAME),)
define CONFIGURE_MAME_ADVANCEMAME_START
	echo -e '\t\t<emulator name="advancemame">' >> $(SYSTEM_XML_MAME)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_MAME)

endef
RECALBOX_ROMFS_MAME_CONFIGURE_CMDS += $(CONFIGURE_MAME_ADVANCEMAME_START)

ifeq ($(BR2_PACKAGE_ADVANCEMAME),y)
define CONFIGURE_MAME_ADVANCEMAME_ADVANCEMAME_DEF
	echo -e '\t\t\t\t<core>advancemame</core>' >> $(SYSTEM_XML_MAME)

endef
RECALBOX_ROMFS_MAME_CONFIGURE_CMDS += $(CONFIGURE_MAME_ADVANCEMAME_ADVANCEMAME_DEF)
endif

define CONFIGURE_MAME_ADVANCEMAME_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_MAME)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_MAME)

endef
RECALBOX_ROMFS_MAME_CONFIGURE_CMDS += $(CONFIGURE_MAME_ADVANCEMAME_END)
endif



define CONFIGURE_MAIN_MAME_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_MAME)
	cp -R $(SOURCE_ROMDIR_MAME) $(@D)
endef
RECALBOX_ROMFS_MAME_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MAME_END)
endif

$(eval $(generic-package))
