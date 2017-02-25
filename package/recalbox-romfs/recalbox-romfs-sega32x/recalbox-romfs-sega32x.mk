################################################################################
#
# recalbox-romfs-sega32x
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system sega32x --extension '.32x .32X .smd .SMD .bin .zip .ZIP' --fullname 'Sega 32X' --platform sega32x --theme sega32x libretro:picodrive:BR2_PACKAGE_LIBRETRO_PICODRIVE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_SEGA32X_SOURCE = 
RECALBOX_ROMFS_SEGA32X_SITE = 
RECALBOX_ROMFS_SEGA32X_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_SEGA32X = sega32x
SYSTEM_XML_SEGA32X = $(@D)/$(SYSTEM_NAME_SEGA32X).xml
# System rom path
SOURCE_ROMDIR_SEGA32X = $(RECALBOX_ROMFS_SEGA32X_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_MAIN_SEGA32X_START
	echo -e '<system>\n' \
	'\t<fullname>Sega 32X</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_SEGA32X)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_SEGA32X)</path>\n' \
	'\t<extension>.32x .32X .smd .SMD .bin .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>sega32x</platform>\n' \
	'\t<theme>sega32x</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_SEGA32X)

endef
RECALBOX_ROMFS_SEGA32X_CONFIGURE_CMDS += $(CONFIGURE_MAIN_SEGA32X_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
define CONFIGURE_SEGA32X_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_SEGA32X)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_SEGA32X)

endef
RECALBOX_ROMFS_SEGA32X_CONFIGURE_CMDS += $(CONFIGURE_SEGA32X_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_PICODRIVE),y)
define CONFIGURE_SEGA32X_LIBRETRO_PICODRIVE_DEF
	echo -e '\t\t\t\t<core>picodrive</core>' >> $(SYSTEM_XML_SEGA32X)

endef
RECALBOX_ROMFS_SEGA32X_CONFIGURE_CMDS += $(CONFIGURE_SEGA32X_LIBRETRO_PICODRIVE_DEF)
endif

define CONFIGURE_SEGA32X_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_SEGA32X)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_SEGA32X)

endef
RECALBOX_ROMFS_SEGA32X_CONFIGURE_CMDS += $(CONFIGURE_SEGA32X_LIBRETRO_END)
endif



define CONFIGURE_MAIN_SEGA32X_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_SEGA32X)
	cp -R $(SOURCE_ROMDIR_SEGA32X) $(@D)
endef
RECALBOX_ROMFS_SEGA32X_CONFIGURE_CMDS += $(CONFIGURE_MAIN_SEGA32X_END)
endif

$(eval $(generic-package))
