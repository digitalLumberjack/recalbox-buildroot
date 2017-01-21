################################################################################
#
# recalbox-romfs-wswan
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system wswan --extension '.ws .WS .wsc .WSC .zip .ZIP' --fullname 'WonderSwan' --platform wonderswan --theme wonderswan libretro:mednafen_wswan:BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN

# Name the 3 vars as the package requires
RECALBOX_ROMFS_WSWAN_SOURCE = 
RECALBOX_ROMFS_WSWAN_SITE = 
RECALBOX_ROMFS_WSWAN_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_WSWAN = wswan
SYSTEM_XML_WSWAN = $(@D)/$(SYSTEM_NAME_WSWAN).xml
# System rom path
SOURCE_ROMDIR_WSWAN = $(RECALBOX_ROMFS_WSWAN_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN),)
define CONFIGURE_MAIN_WSWAN_START
	echo -e '<system>\n' \
	'\t<fullname>WonderSwan</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_WSWAN)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_WSWAN)</path>\n' \
	'\t<extension>.ws .WS .wsc .WSC .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>wonderswan</platform>\n' \
	'\t<theme>wonderswan</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_WSWAN)

endef
RECALBOX_ROMFS_WSWAN_CONFIGURE_CMDS += $(CONFIGURE_MAIN_WSWAN_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN),)
define CONFIGURE_WSWAN_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_WSWAN)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_WSWAN)

endef
RECALBOX_ROMFS_WSWAN_CONFIGURE_CMDS += $(CONFIGURE_WSWAN_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN),y)
define CONFIGURE_WSWAN_LIBRETRO_MEDNAFEN_WSWAN_DEF
	echo -e '\t\t\t\t<core>mednafen_wswan</core>' >> $(SYSTEM_XML_WSWAN)

endef
RECALBOX_ROMFS_WSWAN_CONFIGURE_CMDS += $(CONFIGURE_WSWAN_LIBRETRO_MEDNAFEN_WSWAN_DEF)
endif

define CONFIGURE_WSWAN_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_WSWAN)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_WSWAN)

endef
RECALBOX_ROMFS_WSWAN_CONFIGURE_CMDS += $(CONFIGURE_WSWAN_LIBRETRO_END)
endif



define CONFIGURE_MAIN_WSWAN_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_WSWAN)
	cp -R $(SOURCE_ROMDIR_WSWAN) $(@D)
endef
RECALBOX_ROMFS_WSWAN_CONFIGURE_CMDS += $(CONFIGURE_MAIN_WSWAN_END)
endif

$(eval $(generic-package))
