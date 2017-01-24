################################################################################
#
# recalbox-romfs-gb
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system gb --extension '.gb .GB .zip .ZIP' --fullname 'Game Boy' --platform gb --theme gb libretro:gambatte:BR2_PACKAGE_LIBRETRO_GAMBATTE libretro:tgbdual:BR2_PACKAGE_LIBRETRO_TGBDUAL

# Name the 3 vars as the package requires
RECALBOX_ROMFS_GB_SOURCE = 
RECALBOX_ROMFS_GB_SITE = 
RECALBOX_ROMFS_GB_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_GB = gb
SYSTEM_XML_GB = $(@D)/$(SYSTEM_NAME_GB).xml
# System rom path
SOURCE_ROMDIR_GB = $(RECALBOX_ROMFS_GB_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE)$(BR2_PACKAGE_LIBRETRO_TGBDUAL),)
define CONFIGURE_MAIN_GB_START
	echo -e '<system>\n' \
	'\t<fullname>Game Boy</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_GB)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_GB)</path>\n' \
	'\t<extension>.gb .GB .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>gb</platform>\n' \
	'\t<theme>gb</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_GB)

endef
RECALBOX_ROMFS_GB_CONFIGURE_CMDS += $(CONFIGURE_MAIN_GB_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE)$(BR2_PACKAGE_LIBRETRO_TGBDUAL),)
define CONFIGURE_GB_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_GB)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_GB)

endef
RECALBOX_ROMFS_GB_CONFIGURE_CMDS += $(CONFIGURE_GB_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE),y)
define CONFIGURE_GB_LIBRETRO_GAMBATTE_DEF
	echo -e '\t\t\t\t<core>gambatte</core>' >> $(SYSTEM_XML_GB)

endef
RECALBOX_ROMFS_GB_CONFIGURE_CMDS += $(CONFIGURE_GB_LIBRETRO_GAMBATTE_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_TGBDUAL),y)
define CONFIGURE_GB_LIBRETRO_TGBDUAL_DEF
	echo -e '\t\t\t\t<core>tgbdual</core>' >> $(SYSTEM_XML_GB)

endef
RECALBOX_ROMFS_GB_CONFIGURE_CMDS += $(CONFIGURE_GB_LIBRETRO_TGBDUAL_DEF)
endif

define CONFIGURE_GB_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_GB)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_GB)

endef
RECALBOX_ROMFS_GB_CONFIGURE_CMDS += $(CONFIGURE_GB_LIBRETRO_END)
endif



define CONFIGURE_MAIN_GB_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_GB)
	cp -R $(SOURCE_ROMDIR_GB) $(@D)
endef
RECALBOX_ROMFS_GB_CONFIGURE_CMDS += $(CONFIGURE_MAIN_GB_END)
endif

$(eval $(generic-package))
