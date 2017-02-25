################################################################################
#
# recalbox-romfs-gw
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system gw --extension '.zip .ZIP .mgw .MGW' --fullname 'Game and Watch' --platform gw --theme gw libretro:vb:BR2_PACKAGE_LIBRETRO_GW

# Name the 3 vars as the package requires
RECALBOX_ROMFS_GW_SOURCE = 
RECALBOX_ROMFS_GW_SITE = 
RECALBOX_ROMFS_GW_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_GW = gw
SYSTEM_XML_GW = $(@D)/$(SYSTEM_NAME_GW).xml
# System rom path
SOURCE_ROMDIR_GW = $(RECALBOX_ROMFS_GW_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_GW),)
define CONFIGURE_MAIN_GW_START
	echo -e '<system>\n' \
	'\t<fullname>Game and Watch</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_GW)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_GW)</path>\n' \
	'\t<extension>.zip .ZIP .mgw .MGW</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>gw</platform>\n' \
	'\t<theme>gw</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_GW)

endef
RECALBOX_ROMFS_GW_CONFIGURE_CMDS += $(CONFIGURE_MAIN_GW_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_GW),)
define CONFIGURE_GW_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_GW)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_GW)

endef
RECALBOX_ROMFS_GW_CONFIGURE_CMDS += $(CONFIGURE_GW_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_GW),y)
define CONFIGURE_GW_LIBRETRO_VB_DEF
	echo -e '\t\t\t\t<core>vb</core>' >> $(SYSTEM_XML_GW)

endef
RECALBOX_ROMFS_GW_CONFIGURE_CMDS += $(CONFIGURE_GW_LIBRETRO_VB_DEF)
endif

define CONFIGURE_GW_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_GW)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_GW)

endef
RECALBOX_ROMFS_GW_CONFIGURE_CMDS += $(CONFIGURE_GW_LIBRETRO_END)
endif



define CONFIGURE_MAIN_GW_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_GW)
	cp -R $(SOURCE_ROMDIR_GW) $(@D)
endef
RECALBOX_ROMFS_GW_CONFIGURE_CMDS += $(CONFIGURE_MAIN_GW_END)
endif

$(eval $(generic-package))
