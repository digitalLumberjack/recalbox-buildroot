################################################################################
#
# recalbox-romfs-atari7800
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system atari7800 --extension '.a78 .A78 .bin .BIN .zip .ZIP' --fullname 'Atari 7800' --platform atari7800 --theme atari7800 libretro:prosystem:BR2_PACKAGE_LIBRETRO_PROSYSTEM

# Name the 3 vars as the package requires
RECALBOX_ROMFS_ATARI7800_SOURCE = 
RECALBOX_ROMFS_ATARI7800_SITE = 
RECALBOX_ROMFS_ATARI7800_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_ATARI7800 = atari7800
SYSTEM_XML_ATARI7800 = $(@D)/$(SYSTEM_NAME_ATARI7800).xml
# System rom path
SOURCE_ROMDIR_ATARI7800 = $(RECALBOX_ROMFS_ATARI7800_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_PROSYSTEM),)
define CONFIGURE_MAIN_ATARI7800_START
	echo -e '<system>\n' \
	'\t<fullname>Atari 7800</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_ATARI7800)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_ATARI7800)</path>\n' \
	'\t<extension>.a78 .A78 .bin .BIN .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>atari7800</platform>\n' \
	'\t<theme>atari7800</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_ATARI7800)

endef
RECALBOX_ROMFS_ATARI7800_CONFIGURE_CMDS += $(CONFIGURE_MAIN_ATARI7800_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_PROSYSTEM),)
define CONFIGURE_ATARI7800_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_ATARI7800)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_ATARI7800)

endef
RECALBOX_ROMFS_ATARI7800_CONFIGURE_CMDS += $(CONFIGURE_ATARI7800_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_PROSYSTEM),y)
define CONFIGURE_ATARI7800_LIBRETRO_PROSYSTEM_DEF
	echo -e '\t\t\t\t<core>prosystem</core>' >> $(SYSTEM_XML_ATARI7800)

endef
RECALBOX_ROMFS_ATARI7800_CONFIGURE_CMDS += $(CONFIGURE_ATARI7800_LIBRETRO_PROSYSTEM_DEF)
endif

define CONFIGURE_ATARI7800_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_ATARI7800)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_ATARI7800)

endef
RECALBOX_ROMFS_ATARI7800_CONFIGURE_CMDS += $(CONFIGURE_ATARI7800_LIBRETRO_END)
endif



define CONFIGURE_MAIN_ATARI7800_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_ATARI7800)
	cp -R $(SOURCE_ROMDIR_ATARI7800) $(@D)
endef
RECALBOX_ROMFS_ATARI7800_CONFIGURE_CMDS += $(CONFIGURE_MAIN_ATARI7800_END)
endif

$(eval $(generic-package))
