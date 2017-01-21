################################################################################
#
# recalbox-romfs-atari2600
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system atari2600 --extension '.a26 .A26 .bin .BIN .zip .ZIP' --fullname 'Atari 2600' --platform atari2600 --theme atari2600 libretro:stella:BR2_PACKAGE_LIBRETRO_STELLA

# Name the 3 vars as the package requires
RECALBOX_ROMFS_ATARI2600_SOURCE = 
RECALBOX_ROMFS_ATARI2600_SITE = 
RECALBOX_ROMFS_ATARI2600_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_ATARI2600 = atari2600
SYSTEM_XML_ATARI2600 = $(@D)/$(SYSTEM_NAME_ATARI2600).xml
# System rom path
SOURCE_ROMDIR_ATARI2600 = $(RECALBOX_ROMFS_ATARI2600_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_STELLA),)
define CONFIGURE_MAIN_ATARI2600_START
	echo -e '<system>\n' \
	'\t<fullname>Atari 2600</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_ATARI2600)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_ATARI2600)</path>\n' \
	'\t<extension>.a26 .A26 .bin .BIN .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>atari2600</platform>\n' \
	'\t<theme>atari2600</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_ATARI2600)

endef
RECALBOX_ROMFS_ATARI2600_CONFIGURE_CMDS += $(CONFIGURE_MAIN_ATARI2600_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_STELLA),)
define CONFIGURE_ATARI2600_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_ATARI2600)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_ATARI2600)

endef
RECALBOX_ROMFS_ATARI2600_CONFIGURE_CMDS += $(CONFIGURE_ATARI2600_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_STELLA),y)
define CONFIGURE_ATARI2600_LIBRETRO_STELLA_DEF
	echo -e '\t\t\t\t<core>stella</core>' >> $(SYSTEM_XML_ATARI2600)

endef
RECALBOX_ROMFS_ATARI2600_CONFIGURE_CMDS += $(CONFIGURE_ATARI2600_LIBRETRO_STELLA_DEF)
endif

define CONFIGURE_ATARI2600_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_ATARI2600)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_ATARI2600)

endef
RECALBOX_ROMFS_ATARI2600_CONFIGURE_CMDS += $(CONFIGURE_ATARI2600_LIBRETRO_END)
endif



define CONFIGURE_MAIN_ATARI2600_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_ATARI2600)
	cp -R $(SOURCE_ROMDIR_ATARI2600) $(@D)
endef
RECALBOX_ROMFS_ATARI2600_CONFIGURE_CMDS += $(CONFIGURE_MAIN_ATARI2600_END)
endif

$(eval $(generic-package))
