################################################################################
#
# recalbox-romfs-ngpc
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system ngpc --extension '.zip .ZIP .ngc .NGC .ngp .NGP' --fullname 'Neo-Geo Pocket Color' --platform ngpc --theme ngpc libretro:mednafen_ngp:BR2_PACKAGE_LIBRETRO_BEETLE_NGP

# Name the 3 vars as the package requires
RECALBOX_ROMFS_NGPC_SOURCE = 
RECALBOX_ROMFS_NGPC_SITE = 
RECALBOX_ROMFS_NGPC_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_NGPC = ngpc
SYSTEM_XML_NGPC = $(@D)/$(SYSTEM_NAME_NGPC).xml
# System rom path
SOURCE_ROMDIR_NGPC = $(RECALBOX_ROMFS_NGPC_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),)
define CONFIGURE_MAIN_NGPC_START
	echo -e '<system>\n' \
	'\t<fullname>Neo-Geo Pocket Color</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_NGPC)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_NGPC)</path>\n' \
	'\t<extension>.zip .ZIP .ngc .NGC .ngp .NGP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>ngpc</platform>\n' \
	'\t<theme>ngpc</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_NGPC)

endef
RECALBOX_ROMFS_NGPC_CONFIGURE_CMDS += $(CONFIGURE_MAIN_NGPC_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),)
define CONFIGURE_NGPC_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_NGPC)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_NGPC)

endef
RECALBOX_ROMFS_NGPC_CONFIGURE_CMDS += $(CONFIGURE_NGPC_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),y)
define CONFIGURE_NGPC_LIBRETRO_MEDNAFEN_NGP_DEF
	echo -e '\t\t\t\t<core>mednafen_ngp</core>' >> $(SYSTEM_XML_NGPC)

endef
RECALBOX_ROMFS_NGPC_CONFIGURE_CMDS += $(CONFIGURE_NGPC_LIBRETRO_MEDNAFEN_NGP_DEF)
endif

define CONFIGURE_NGPC_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_NGPC)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_NGPC)

endef
RECALBOX_ROMFS_NGPC_CONFIGURE_CMDS += $(CONFIGURE_NGPC_LIBRETRO_END)
endif



define CONFIGURE_MAIN_NGPC_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_NGPC)
	cp -R $(SOURCE_ROMDIR_NGPC) $(@D)
endef
RECALBOX_ROMFS_NGPC_CONFIGURE_CMDS += $(CONFIGURE_MAIN_NGPC_END)
endif

$(eval $(generic-package))
