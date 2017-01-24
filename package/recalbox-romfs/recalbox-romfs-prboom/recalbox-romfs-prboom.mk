################################################################################
#
# recalbox-romfs-prboom
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system prboom --extension '.wad .WAD' --fullname 'PrBoom' --platform prboom --theme prboom libretro:prboom:BR2_PACKAGE_LIBRETRO_PRBOOM

# Name the 3 vars as the package requires
RECALBOX_ROMFS_PRBOOM_SOURCE = 
RECALBOX_ROMFS_PRBOOM_SITE = 
RECALBOX_ROMFS_PRBOOM_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_PRBOOM = prboom
SYSTEM_XML_PRBOOM = $(@D)/$(SYSTEM_NAME_PRBOOM).xml
# System rom path
SOURCE_ROMDIR_PRBOOM = $(RECALBOX_ROMFS_PRBOOM_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_PRBOOM),)
define CONFIGURE_MAIN_PRBOOM_START
	echo -e '<system>\n' \
	'\t<fullname>PrBoom</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_PRBOOM)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_PRBOOM)</path>\n' \
	'\t<extension>.wad .WAD</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>prboom</platform>\n' \
	'\t<theme>prboom</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_PRBOOM)

endef
RECALBOX_ROMFS_PRBOOM_CONFIGURE_CMDS += $(CONFIGURE_MAIN_PRBOOM_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_PRBOOM),)
define CONFIGURE_PRBOOM_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_PRBOOM)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_PRBOOM)

endef
RECALBOX_ROMFS_PRBOOM_CONFIGURE_CMDS += $(CONFIGURE_PRBOOM_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_PRBOOM),y)
define CONFIGURE_PRBOOM_LIBRETRO_PRBOOM_DEF
	echo -e '\t\t\t\t<core>prboom</core>' >> $(SYSTEM_XML_PRBOOM)

endef
RECALBOX_ROMFS_PRBOOM_CONFIGURE_CMDS += $(CONFIGURE_PRBOOM_LIBRETRO_PRBOOM_DEF)
endif

define CONFIGURE_PRBOOM_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_PRBOOM)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_PRBOOM)

endef
RECALBOX_ROMFS_PRBOOM_CONFIGURE_CMDS += $(CONFIGURE_PRBOOM_LIBRETRO_END)
endif



define CONFIGURE_MAIN_PRBOOM_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_PRBOOM)
	cp -R $(SOURCE_ROMDIR_PRBOOM) $(@D)
endef
RECALBOX_ROMFS_PRBOOM_CONFIGURE_CMDS += $(CONFIGURE_MAIN_PRBOOM_END)
endif

$(eval $(generic-package))
