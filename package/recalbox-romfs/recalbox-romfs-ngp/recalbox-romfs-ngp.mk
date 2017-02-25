################################################################################
#
# recalbox-romfs-ngp
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system ngp --extension '.zip .ZIP .ngc .NGC .ngp .NGP' --fullname 'Neo-Geo Pocket' --platform ngp --theme ngp libretro:mednafen_ngp:BR2_PACKAGE_LIBRETRO_BEETLE_NGP

# Name the 3 vars as the package requires
RECALBOX_ROMFS_NGP_SOURCE = 
RECALBOX_ROMFS_NGP_SITE = 
RECALBOX_ROMFS_NGP_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_NGP = ngp
SYSTEM_XML_NGP = $(@D)/$(SYSTEM_NAME_NGP).xml
# System rom path
SOURCE_ROMDIR_NGP = $(RECALBOX_ROMFS_NGP_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),)
define CONFIGURE_MAIN_NGP_START
	echo -e '<system>\n' \
	'\t<fullname>Neo-Geo Pocket</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_NGP)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_NGP)</path>\n' \
	'\t<extension>.zip .ZIP .ngc .NGC .ngp .NGP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>ngp</platform>\n' \
	'\t<theme>ngp</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_NGP)

endef
RECALBOX_ROMFS_NGP_CONFIGURE_CMDS += $(CONFIGURE_MAIN_NGP_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),)
define CONFIGURE_NGP_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_NGP)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_NGP)

endef
RECALBOX_ROMFS_NGP_CONFIGURE_CMDS += $(CONFIGURE_NGP_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),y)
define CONFIGURE_NGP_LIBRETRO_MEDNAFEN_NGP_DEF
	echo -e '\t\t\t\t<core>mednafen_ngp</core>' >> $(SYSTEM_XML_NGP)

endef
RECALBOX_ROMFS_NGP_CONFIGURE_CMDS += $(CONFIGURE_NGP_LIBRETRO_MEDNAFEN_NGP_DEF)
endif

define CONFIGURE_NGP_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_NGP)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_NGP)

endef
RECALBOX_ROMFS_NGP_CONFIGURE_CMDS += $(CONFIGURE_NGP_LIBRETRO_END)
endif



define CONFIGURE_MAIN_NGP_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_NGP)
	cp -R $(SOURCE_ROMDIR_NGP) $(@D)
endef
RECALBOX_ROMFS_NGP_CONFIGURE_CMDS += $(CONFIGURE_MAIN_NGP_END)
endif

$(eval $(generic-package))
