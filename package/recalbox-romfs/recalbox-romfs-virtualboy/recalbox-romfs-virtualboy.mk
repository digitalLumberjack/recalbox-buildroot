################################################################################
#
# recalbox-romfs-virtualboy
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system virtualboy --extension '.vb .VB .zip .ZIP' --fullname 'Virtual Boy' --platform virtualboy --theme virtualboy libretro:mednafen_vb:BR2_PACKAGE_LIBRETRO_BEETLE_VB

# Name the 3 vars as the package requires
RECALBOX_ROMFS_VIRTUALBOY_SOURCE = 
RECALBOX_ROMFS_VIRTUALBOY_SITE = 
RECALBOX_ROMFS_VIRTUALBOY_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_VIRTUALBOY = virtualboy
SYSTEM_XML_VIRTUALBOY = $(@D)/$(SYSTEM_NAME_VIRTUALBOY).xml
# System rom path
SOURCE_ROMDIR_VIRTUALBOY = $(RECALBOX_ROMFS_VIRTUALBOY_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_VB),)
define CONFIGURE_MAIN_VIRTUALBOY_START
	echo -e '<system>\n' \
	'\t<fullname>Virtual Boy</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_VIRTUALBOY)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_VIRTUALBOY)</path>\n' \
	'\t<extension>.vb .VB .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>virtualboy</platform>\n' \
	'\t<theme>virtualboy</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_VIRTUALBOY)

endef
RECALBOX_ROMFS_VIRTUALBOY_CONFIGURE_CMDS += $(CONFIGURE_MAIN_VIRTUALBOY_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_VB),)
define CONFIGURE_VIRTUALBOY_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_VIRTUALBOY)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_VIRTUALBOY)

endef
RECALBOX_ROMFS_VIRTUALBOY_CONFIGURE_CMDS += $(CONFIGURE_VIRTUALBOY_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_VB),y)
define CONFIGURE_VIRTUALBOY_LIBRETRO_MEDNAFEN_VB_DEF
	echo -e '\t\t\t\t<core>mednafen_vb</core>' >> $(SYSTEM_XML_VIRTUALBOY)

endef
RECALBOX_ROMFS_VIRTUALBOY_CONFIGURE_CMDS += $(CONFIGURE_VIRTUALBOY_LIBRETRO_MEDNAFEN_VB_DEF)
endif

define CONFIGURE_VIRTUALBOY_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_VIRTUALBOY)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_VIRTUALBOY)

endef
RECALBOX_ROMFS_VIRTUALBOY_CONFIGURE_CMDS += $(CONFIGURE_VIRTUALBOY_LIBRETRO_END)
endif



define CONFIGURE_MAIN_VIRTUALBOY_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_VIRTUALBOY)
	cp -R $(SOURCE_ROMDIR_VIRTUALBOY) $(@D)
endef
RECALBOX_ROMFS_VIRTUALBOY_CONFIGURE_CMDS += $(CONFIGURE_MAIN_VIRTUALBOY_END)
endif

$(eval $(generic-package))
