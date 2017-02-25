################################################################################
#
# recalbox-romfs-lynx
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system lynx --extension '.zip .ZIP .lnx .LNX' --fullname 'Lynx' --platform atarilynx --theme lynx libretro:atarilynx:BR2_PACKAGE_LIBRETRO_BEETLE_LYNX

# Name the 3 vars as the package requires
RECALBOX_ROMFS_LYNX_SOURCE = 
RECALBOX_ROMFS_LYNX_SITE = 
RECALBOX_ROMFS_LYNX_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_LYNX = lynx
SYSTEM_XML_LYNX = $(@D)/$(SYSTEM_NAME_LYNX).xml
# System rom path
SOURCE_ROMDIR_LYNX = $(RECALBOX_ROMFS_LYNX_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_LYNX),)
define CONFIGURE_MAIN_LYNX_START
	echo -e '<system>\n' \
	'\t<fullname>Lynx</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_LYNX)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_LYNX)</path>\n' \
	'\t<extension>.zip .ZIP .lnx .LNX</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>atarilynx</platform>\n' \
	'\t<theme>lynx</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_LYNX)

endef
RECALBOX_ROMFS_LYNX_CONFIGURE_CMDS += $(CONFIGURE_MAIN_LYNX_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_LYNX),)
define CONFIGURE_LYNX_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_LYNX)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_LYNX)

endef
RECALBOX_ROMFS_LYNX_CONFIGURE_CMDS += $(CONFIGURE_LYNX_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_LYNX),y)
define CONFIGURE_LYNX_LIBRETRO_ATARILYNX_DEF
	echo -e '\t\t\t\t<core>atarilynx</core>' >> $(SYSTEM_XML_LYNX)

endef
RECALBOX_ROMFS_LYNX_CONFIGURE_CMDS += $(CONFIGURE_LYNX_LIBRETRO_ATARILYNX_DEF)
endif

define CONFIGURE_LYNX_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_LYNX)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_LYNX)

endef
RECALBOX_ROMFS_LYNX_CONFIGURE_CMDS += $(CONFIGURE_LYNX_LIBRETRO_END)
endif



define CONFIGURE_MAIN_LYNX_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_LYNX)
	cp -R $(SOURCE_ROMDIR_LYNX) $(@D)
endef
RECALBOX_ROMFS_LYNX_CONFIGURE_CMDS += $(CONFIGURE_MAIN_LYNX_END)
endif

$(eval $(generic-package))
