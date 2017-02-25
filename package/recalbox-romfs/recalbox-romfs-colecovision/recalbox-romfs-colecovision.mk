################################################################################
#
# recalbox-romfs-colecovision
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system colecovision --extension '.col .COL .zip .ZIP' --fullname 'Colecovision' --platform colecovision --theme colecovision libretro:bluemsx:BR2_PACKAGE_LIBRETRO_BLUEMSX

# Name the 3 vars as the package requires
RECALBOX_ROMFS_COLECOVISION_SOURCE = 
RECALBOX_ROMFS_COLECOVISION_SITE = 
RECALBOX_ROMFS_COLECOVISION_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_COLECOVISION = colecovision
SYSTEM_XML_COLECOVISION = $(@D)/$(SYSTEM_NAME_COLECOVISION).xml
# System rom path
SOURCE_ROMDIR_COLECOVISION = $(RECALBOX_ROMFS_COLECOVISION_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
define CONFIGURE_MAIN_COLECOVISION_START
	echo -e '<system>\n' \
	'\t<fullname>Colecovision</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_COLECOVISION)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_COLECOVISION)</path>\n' \
	'\t<extension>.col .COL .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>colecovision</platform>\n' \
	'\t<theme>colecovision</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_COLECOVISION)

endef
RECALBOX_ROMFS_COLECOVISION_CONFIGURE_CMDS += $(CONFIGURE_MAIN_COLECOVISION_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
define CONFIGURE_COLECOVISION_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_COLECOVISION)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_COLECOVISION)

endef
RECALBOX_ROMFS_COLECOVISION_CONFIGURE_CMDS += $(CONFIGURE_COLECOVISION_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),y)
define CONFIGURE_COLECOVISION_LIBRETRO_BLUEMSX_DEF
	echo -e '\t\t\t\t<core>bluemsx</core>' >> $(SYSTEM_XML_COLECOVISION)

endef
RECALBOX_ROMFS_COLECOVISION_CONFIGURE_CMDS += $(CONFIGURE_COLECOVISION_LIBRETRO_BLUEMSX_DEF)
endif

define CONFIGURE_COLECOVISION_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_COLECOVISION)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_COLECOVISION)

endef
RECALBOX_ROMFS_COLECOVISION_CONFIGURE_CMDS += $(CONFIGURE_COLECOVISION_LIBRETRO_END)
endif



define CONFIGURE_MAIN_COLECOVISION_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_COLECOVISION)
	cp -R $(SOURCE_ROMDIR_COLECOVISION) $(@D)
endef
RECALBOX_ROMFS_COLECOVISION_CONFIGURE_CMDS += $(CONFIGURE_MAIN_COLECOVISION_END)
endif

$(eval $(generic-package))
