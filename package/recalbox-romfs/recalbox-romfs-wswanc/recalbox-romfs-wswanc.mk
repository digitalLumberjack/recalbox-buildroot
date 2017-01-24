################################################################################
#
# recalbox-romfs-wswanc
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system wswanc --extension '.ws .WS .wsc .WSC .zip .ZIP' --fullname 'WonderSwan Color' --platform wonderswancolor --theme wonderswancolor libretro:mednafen_wswan:BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN

# Name the 3 vars as the package requires
RECALBOX_ROMFS_WSWANC_SOURCE = 
RECALBOX_ROMFS_WSWANC_SITE = 
RECALBOX_ROMFS_WSWANC_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_WSWANC = wswanc
SYSTEM_XML_WSWANC = $(@D)/$(SYSTEM_NAME_WSWANC).xml
# System rom path
SOURCE_ROMDIR_WSWANC = $(RECALBOX_ROMFS_WSWANC_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN),)
define CONFIGURE_MAIN_WSWANC_START
	echo -e '<system>\n' \
	'\t<fullname>WonderSwan Color</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_WSWANC)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_WSWANC)</path>\n' \
	'\t<extension>.ws .WS .wsc .WSC .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>wonderswancolor</platform>\n' \
	'\t<theme>wonderswancolor</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_WSWANC)

endef
RECALBOX_ROMFS_WSWANC_CONFIGURE_CMDS += $(CONFIGURE_MAIN_WSWANC_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN),)
define CONFIGURE_WSWANC_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_WSWANC)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_WSWANC)

endef
RECALBOX_ROMFS_WSWANC_CONFIGURE_CMDS += $(CONFIGURE_WSWANC_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN),y)
define CONFIGURE_WSWANC_LIBRETRO_MEDNAFEN_WSWAN_DEF
	echo -e '\t\t\t\t<core>mednafen_wswan</core>' >> $(SYSTEM_XML_WSWANC)

endef
RECALBOX_ROMFS_WSWANC_CONFIGURE_CMDS += $(CONFIGURE_WSWANC_LIBRETRO_MEDNAFEN_WSWAN_DEF)
endif

define CONFIGURE_WSWANC_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_WSWANC)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_WSWANC)

endef
RECALBOX_ROMFS_WSWANC_CONFIGURE_CMDS += $(CONFIGURE_WSWANC_LIBRETRO_END)
endif



define CONFIGURE_MAIN_WSWANC_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_WSWANC)
	cp -R $(SOURCE_ROMDIR_WSWANC) $(@D)
endef
RECALBOX_ROMFS_WSWANC_CONFIGURE_CMDS += $(CONFIGURE_MAIN_WSWANC_END)
endif

$(eval $(generic-package))
