################################################################################
#
# recalbox-romfs-atarist
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system atarist --extension '.st .ST .stx .STX .zip .ZIP' --fullname 'Atari ST' --platform atarist --theme atarist libretro:hatari:BR2_PACKAGE_LIBRETRO_HATARI

# Name the 3 vars as the package requires
RECALBOX_ROMFS_ATARIST_SOURCE = 
RECALBOX_ROMFS_ATARIST_SITE = 
RECALBOX_ROMFS_ATARIST_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_ATARIST = atarist
SYSTEM_XML_ATARIST = $(@D)/$(SYSTEM_NAME_ATARIST).xml
# System rom path
SOURCE_ROMDIR_ATARIST = $(RECALBOX_ROMFS_ATARIST_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_HATARI),)
define CONFIGURE_MAIN_ATARIST_START
	echo -e '<system>\n' \
	'\t<fullname>Atari ST</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_ATARIST)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_ATARIST)</path>\n' \
	'\t<extension>.st .ST .stx .STX .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>atarist</platform>\n' \
	'\t<theme>atarist</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_ATARIST)

endef
RECALBOX_ROMFS_ATARIST_CONFIGURE_CMDS += $(CONFIGURE_MAIN_ATARIST_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_HATARI),)
define CONFIGURE_ATARIST_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_ATARIST)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_ATARIST)

endef
RECALBOX_ROMFS_ATARIST_CONFIGURE_CMDS += $(CONFIGURE_ATARIST_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_HATARI),y)
define CONFIGURE_ATARIST_LIBRETRO_HATARI_DEF
	echo -e '\t\t\t\t<core>hatari</core>' >> $(SYSTEM_XML_ATARIST)

endef
RECALBOX_ROMFS_ATARIST_CONFIGURE_CMDS += $(CONFIGURE_ATARIST_LIBRETRO_HATARI_DEF)
endif

define CONFIGURE_ATARIST_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_ATARIST)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_ATARIST)

endef
RECALBOX_ROMFS_ATARIST_CONFIGURE_CMDS += $(CONFIGURE_ATARIST_LIBRETRO_END)
endif



define CONFIGURE_MAIN_ATARIST_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_ATARIST)
	cp -R $(SOURCE_ROMDIR_ATARIST) $(@D)
endef
RECALBOX_ROMFS_ATARIST_CONFIGURE_CMDS += $(CONFIGURE_MAIN_ATARIST_END)
endif

$(eval $(generic-package))
