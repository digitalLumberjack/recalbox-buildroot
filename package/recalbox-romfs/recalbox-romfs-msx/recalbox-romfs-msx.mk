################################################################################
#
# recalbox-romfs-msx
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system msx --extension '.mx1 .MX1 .mx2 .MX2 .rom .ROM .zip .ZIP' --fullname 'MSX' --platform msx --theme msx libretro:bluemsx:BR2_PACKAGE_LIBRETRO_BLUEMSX

# Name the 3 vars as the package requires
RECALBOX_ROMFS_MSX_SOURCE = 
RECALBOX_ROMFS_MSX_SITE = 
RECALBOX_ROMFS_MSX_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_MSX = msx
SYSTEM_XML_MSX = $(@D)/$(SYSTEM_NAME_MSX).xml
# System rom path
SOURCE_ROMDIR_MSX = $(RECALBOX_ROMFS_MSX_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
define CONFIGURE_MAIN_MSX_START
	echo -e '<system>\n' \
	'\t<fullname>MSX</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_MSX)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_MSX)</path>\n' \
	'\t<extension>.mx1 .MX1 .mx2 .MX2 .rom .ROM .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>msx</platform>\n' \
	'\t<theme>msx</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_MSX)

endef
RECALBOX_ROMFS_MSX_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MSX_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
define CONFIGURE_MSX_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_MSX)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_MSX)

endef
RECALBOX_ROMFS_MSX_CONFIGURE_CMDS += $(CONFIGURE_MSX_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),y)
define CONFIGURE_MSX_LIBRETRO_BLUEMSX_DEF
	echo -e '\t\t\t\t<core>bluemsx</core>' >> $(SYSTEM_XML_MSX)

endef
RECALBOX_ROMFS_MSX_CONFIGURE_CMDS += $(CONFIGURE_MSX_LIBRETRO_BLUEMSX_DEF)
endif

define CONFIGURE_MSX_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_MSX)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_MSX)

endef
RECALBOX_ROMFS_MSX_CONFIGURE_CMDS += $(CONFIGURE_MSX_LIBRETRO_END)
endif



define CONFIGURE_MAIN_MSX_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_MSX)
	cp -R $(SOURCE_ROMDIR_MSX) $(@D)
endef
RECALBOX_ROMFS_MSX_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MSX_END)
endif

$(eval $(generic-package))
