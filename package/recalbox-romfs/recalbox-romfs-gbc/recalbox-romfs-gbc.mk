################################################################################
#
# recalbox-romfs-gbc
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system gbc --extension '.gb .GB .gbc .GBC .zip .ZIP' --fullname 'Game Boy Color' --platform gbc --theme gbc libretro:gambatte:BR2_PACKAGE_LIBRETRO_GAMBATTE libretro:tgbdual:BR2_PACKAGE_LIBRETRO_TGBDUAL

# Name the 3 vars as the package requires
RECALBOX_ROMFS_GBC_SOURCE = 
RECALBOX_ROMFS_GBC_SITE = 
RECALBOX_ROMFS_GBC_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_GBC = gbc
SYSTEM_XML_GBC = $(@D)/$(SYSTEM_NAME_GBC).xml
# System rom path
SOURCE_ROMDIR_GBC = $(RECALBOX_ROMFS_GBC_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE)$(BR2_PACKAGE_LIBRETRO_TGBDUAL),)
define CONFIGURE_MAIN_GBC_START
	echo -e '<system>\n' \
	'\t<fullname>Game Boy Color</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_GBC)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_GBC)</path>\n' \
	'\t<extension>.gb .GB .gbc .GBC .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>gbc</platform>\n' \
	'\t<theme>gbc</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_GBC)

endef
RECALBOX_ROMFS_GBC_CONFIGURE_CMDS += $(CONFIGURE_MAIN_GBC_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE)$(BR2_PACKAGE_LIBRETRO_TGBDUAL),)
define CONFIGURE_GBC_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_GBC)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_GBC)

endef
RECALBOX_ROMFS_GBC_CONFIGURE_CMDS += $(CONFIGURE_GBC_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE),y)
define CONFIGURE_GBC_LIBRETRO_GAMBATTE_DEF
	echo -e '\t\t\t\t<core>gambatte</core>' >> $(SYSTEM_XML_GBC)

endef
RECALBOX_ROMFS_GBC_CONFIGURE_CMDS += $(CONFIGURE_GBC_LIBRETRO_GAMBATTE_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_TGBDUAL),y)
define CONFIGURE_GBC_LIBRETRO_TGBDUAL_DEF
	echo -e '\t\t\t\t<core>tgbdual</core>' >> $(SYSTEM_XML_GBC)

endef
RECALBOX_ROMFS_GBC_CONFIGURE_CMDS += $(CONFIGURE_GBC_LIBRETRO_TGBDUAL_DEF)
endif

define CONFIGURE_GBC_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_GBC)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_GBC)

endef
RECALBOX_ROMFS_GBC_CONFIGURE_CMDS += $(CONFIGURE_GBC_LIBRETRO_END)
endif



define CONFIGURE_MAIN_GBC_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_GBC)
	cp -R $(SOURCE_ROMDIR_GBC) $(@D)
endef
RECALBOX_ROMFS_GBC_CONFIGURE_CMDS += $(CONFIGURE_MAIN_GBC_END)
endif

$(eval $(generic-package))
