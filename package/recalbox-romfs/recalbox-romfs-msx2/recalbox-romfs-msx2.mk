################################################################################
#
# recalbox-romfs-msx2
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system msx2 --extension '.mx1 .MX1 .mx2 .MX2 .rom .ROM .zip .ZIP' --fullname 'MSX2' --platform msx --theme msx2 libretro:bluemsx:BR2_PACKAGE_LIBRETRO_BLUEMSX

# Name the 3 vars as the package requires
RECALBOX_ROMFS_MSX2_SOURCE = 
RECALBOX_ROMFS_MSX2_SITE = 
RECALBOX_ROMFS_MSX2_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_MSX2 = msx2
SYSTEM_XML_MSX2 = $(@D)/$(SYSTEM_NAME_MSX2).xml
# System rom path
SOURCE_ROMDIR_MSX2 = $(RECALBOX_ROMFS_MSX2_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
define CONFIGURE_MAIN_MSX2_START
	echo -e '<system>\n' \
	'\t<fullname>MSX2</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_MSX2)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_MSX2)</path>\n' \
	'\t<extension>.mx1 .MX1 .mx2 .MX2 .rom .ROM .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>msx</platform>\n' \
	'\t<theme>msx2</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_MSX2)

endef
RECALBOX_ROMFS_MSX2_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MSX2_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
define CONFIGURE_MSX2_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_MSX2)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_MSX2)

endef
RECALBOX_ROMFS_MSX2_CONFIGURE_CMDS += $(CONFIGURE_MSX2_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),y)
define CONFIGURE_MSX2_LIBRETRO_BLUEMSX_DEF
	echo -e '\t\t\t\t<core>bluemsx</core>' >> $(SYSTEM_XML_MSX2)

endef
RECALBOX_ROMFS_MSX2_CONFIGURE_CMDS += $(CONFIGURE_MSX2_LIBRETRO_BLUEMSX_DEF)
endif

define CONFIGURE_MSX2_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_MSX2)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_MSX2)

endef
RECALBOX_ROMFS_MSX2_CONFIGURE_CMDS += $(CONFIGURE_MSX2_LIBRETRO_END)
endif



define CONFIGURE_MAIN_MSX2_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_MSX2)
	cp -R $(SOURCE_ROMDIR_MSX2) $(@D)
endef
RECALBOX_ROMFS_MSX2_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MSX2_END)
endif

$(eval $(generic-package))
