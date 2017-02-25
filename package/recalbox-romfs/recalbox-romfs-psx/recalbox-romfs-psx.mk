################################################################################
#
# recalbox-romfs-psx
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system psx --extension '.img .IMG .pbp .PBP .cue .CUE .iso .ISO .ccd .CCD .cbn .CBN' --fullname 'Sony Playstation 1' --platform psx --theme psx libretro:pcsx_rearmed:BR2_PACKAGE_LIBRETRO_PCSX

# Name the 3 vars as the package requires
RECALBOX_ROMFS_PSX_SOURCE = 
RECALBOX_ROMFS_PSX_SITE = 
RECALBOX_ROMFS_PSX_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_PSX = psx
SYSTEM_XML_PSX = $(@D)/$(SYSTEM_NAME_PSX).xml
# System rom path
SOURCE_ROMDIR_PSX = $(RECALBOX_ROMFS_PSX_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_PCSX),)
define CONFIGURE_MAIN_PSX_START
	echo -e '<system>\n' \
	'\t<fullname>Sony Playstation 1</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_PSX)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_PSX)</path>\n' \
	'\t<extension>.img .IMG .pbp .PBP .cue .CUE .iso .ISO .ccd .CCD .cbn .CBN</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>psx</platform>\n' \
	'\t<theme>psx</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_PSX)

endef
RECALBOX_ROMFS_PSX_CONFIGURE_CMDS += $(CONFIGURE_MAIN_PSX_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_PCSX),)
define CONFIGURE_PSX_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_PSX)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_PSX)

endef
RECALBOX_ROMFS_PSX_CONFIGURE_CMDS += $(CONFIGURE_PSX_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_PCSX),y)
define CONFIGURE_PSX_LIBRETRO_PCSX_REARMED_DEF
	echo -e '\t\t\t\t<core>pcsx_rearmed</core>' >> $(SYSTEM_XML_PSX)

endef
RECALBOX_ROMFS_PSX_CONFIGURE_CMDS += $(CONFIGURE_PSX_LIBRETRO_PCSX_REARMED_DEF)
endif

define CONFIGURE_PSX_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_PSX)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_PSX)

endef
RECALBOX_ROMFS_PSX_CONFIGURE_CMDS += $(CONFIGURE_PSX_LIBRETRO_END)
endif



define CONFIGURE_MAIN_PSX_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_PSX)
	cp -R $(SOURCE_ROMDIR_PSX) $(@D)
endef
RECALBOX_ROMFS_PSX_CONFIGURE_CMDS += $(CONFIGURE_MAIN_PSX_END)
endif

$(eval $(generic-package))
