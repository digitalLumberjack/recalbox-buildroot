################################################################################
#
# recalbox-romfs-msx1
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system msx1 --extension '.mx1 .MX1 .mx2 .MX2 .rom .ROM .zip .ZIP' --fullname 'MSX1' --platform msx --theme msx1 libretro:bluemsx:BR2_PACKAGE_LIBRETRO_BLUEMSX

# Name the 3 vars as the package requires
RECALBOX_ROMFS_MSX1_SOURCE = 
RECALBOX_ROMFS_MSX1_SITE = 
RECALBOX_ROMFS_MSX1_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_MSX1 = msx1
SYSTEM_XML_MSX1 = $(@D)/$(SYSTEM_NAME_MSX1).xml
# System rom path
SOURCE_ROMDIR_MSX1 = $(RECALBOX_ROMFS_MSX1_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
define CONFIGURE_MAIN_MSX1_START
	echo -e '<system>\n' \
	'\t<fullname>MSX1</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_MSX1)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_MSX1)</path>\n' \
	'\t<extension>.mx1 .MX1 .mx2 .MX2 .rom .ROM .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>msx</platform>\n' \
	'\t<theme>msx1</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_MSX1)

endef
RECALBOX_ROMFS_MSX1_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MSX1_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
define CONFIGURE_MSX1_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_MSX1)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_MSX1)

endef
RECALBOX_ROMFS_MSX1_CONFIGURE_CMDS += $(CONFIGURE_MSX1_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),y)
define CONFIGURE_MSX1_LIBRETRO_BLUEMSX_DEF
	echo -e '\t\t\t\t<core>bluemsx</core>' >> $(SYSTEM_XML_MSX1)

endef
RECALBOX_ROMFS_MSX1_CONFIGURE_CMDS += $(CONFIGURE_MSX1_LIBRETRO_BLUEMSX_DEF)
endif

define CONFIGURE_MSX1_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_MSX1)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_MSX1)

endef
RECALBOX_ROMFS_MSX1_CONFIGURE_CMDS += $(CONFIGURE_MSX1_LIBRETRO_END)
endif



define CONFIGURE_MAIN_MSX1_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_MSX1)
	cp -R $(SOURCE_ROMDIR_MSX1) $(@D)
endef
RECALBOX_ROMFS_MSX1_CONFIGURE_CMDS += $(CONFIGURE_MAIN_MSX1_END)
endif

$(eval $(generic-package))
