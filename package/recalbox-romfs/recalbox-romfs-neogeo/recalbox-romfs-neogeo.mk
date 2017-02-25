################################################################################
#
# recalbox-romfs-neogeo
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system neogeo --extension '.zip .ZIP' --fullname 'Neo-Geo' --platform neogeo --theme neogeo libretro:mame078:BR2_PACKAGE_LIBRETRO_MAME2003 libretro:imame4all:BR2_PACKAGE_LIBRETRO_IMAME libretro:fba:BR2_PACKAGE_LIBRETRO_FBA fba2x:fba2x:BR2_PACKAGE_PIFBA

# Name the 3 vars as the package requires
RECALBOX_ROMFS_NEOGEO_SOURCE = 
RECALBOX_ROMFS_NEOGEO_SITE = 
RECALBOX_ROMFS_NEOGEO_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_NEOGEO = neogeo
SYSTEM_XML_NEOGEO = $(@D)/$(SYSTEM_NAME_NEOGEO).xml
# System rom path
SOURCE_ROMDIR_NEOGEO = $(RECALBOX_ROMFS_NEOGEO_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_MAME2003)$(BR2_PACKAGE_LIBRETRO_IMAME)$(BR2_PACKAGE_LIBRETRO_FBA)$(BR2_PACKAGE_PIFBA),)
define CONFIGURE_MAIN_NEOGEO_START
	echo -e '<system>\n' \
	'\t<fullname>Neo-Geo</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_NEOGEO)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_NEOGEO)</path>\n' \
	'\t<extension>.zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>neogeo</platform>\n' \
	'\t<theme>neogeo</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_NEOGEO)

endef
RECALBOX_ROMFS_NEOGEO_CONFIGURE_CMDS += $(CONFIGURE_MAIN_NEOGEO_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_MAME2003)$(BR2_PACKAGE_LIBRETRO_IMAME)$(BR2_PACKAGE_LIBRETRO_FBA)$(BR2_PACKAGE_PIFBA),)
define CONFIGURE_NEOGEO_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_NEOGEO)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_NEOGEO)

endef
RECALBOX_ROMFS_NEOGEO_CONFIGURE_CMDS += $(CONFIGURE_NEOGEO_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_MAME2003),y)
define CONFIGURE_NEOGEO_LIBRETRO_MAME078_DEF
	echo -e '\t\t\t\t<core>mame078</core>' >> $(SYSTEM_XML_NEOGEO)

endef
RECALBOX_ROMFS_NEOGEO_CONFIGURE_CMDS += $(CONFIGURE_NEOGEO_LIBRETRO_MAME078_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_FBA),y)
define CONFIGURE_NEOGEO_LIBRETRO_FBA_DEF
	echo -e '\t\t\t\t<core>fba</core>' >> $(SYSTEM_XML_NEOGEO)

endef
RECALBOX_ROMFS_NEOGEO_CONFIGURE_CMDS += $(CONFIGURE_NEOGEO_LIBRETRO_FBA_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_IMAME),y)
define CONFIGURE_NEOGEO_LIBRETRO_IMAME4ALL_DEF
	echo -e '\t\t\t\t<core>imame4all</core>' >> $(SYSTEM_XML_NEOGEO)

endef
RECALBOX_ROMFS_NEOGEO_CONFIGURE_CMDS += $(CONFIGURE_NEOGEO_LIBRETRO_IMAME4ALL_DEF)
endif

define CONFIGURE_NEOGEO_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_NEOGEO)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_NEOGEO)

endef
RECALBOX_ROMFS_NEOGEO_CONFIGURE_CMDS += $(CONFIGURE_NEOGEO_LIBRETRO_END)
endif

ifneq ($(BR2_PACKAGE_LIBRETRO_MAME2003)$(BR2_PACKAGE_LIBRETRO_IMAME)$(BR2_PACKAGE_LIBRETRO_FBA)$(BR2_PACKAGE_PIFBA),)
define CONFIGURE_NEOGEO_FBA2X_START
	echo -e '\t\t<emulator name="fba2x">' >> $(SYSTEM_XML_NEOGEO)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_NEOGEO)

endef
RECALBOX_ROMFS_NEOGEO_CONFIGURE_CMDS += $(CONFIGURE_NEOGEO_FBA2X_START)

ifeq ($(BR2_PACKAGE_PIFBA),y)
define CONFIGURE_NEOGEO_FBA2X_FBA2X_DEF
	echo -e '\t\t\t\t<core>fba2x</core>' >> $(SYSTEM_XML_NEOGEO)

endef
RECALBOX_ROMFS_NEOGEO_CONFIGURE_CMDS += $(CONFIGURE_NEOGEO_FBA2X_FBA2X_DEF)
endif

define CONFIGURE_NEOGEO_FBA2X_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_NEOGEO)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_NEOGEO)

endef
RECALBOX_ROMFS_NEOGEO_CONFIGURE_CMDS += $(CONFIGURE_NEOGEO_FBA2X_END)
endif



define CONFIGURE_MAIN_NEOGEO_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_NEOGEO)
	cp -R $(SOURCE_ROMDIR_NEOGEO) $(@D)
endef
RECALBOX_ROMFS_NEOGEO_CONFIGURE_CMDS += $(CONFIGURE_MAIN_NEOGEO_END)
endif

$(eval $(generic-package))
