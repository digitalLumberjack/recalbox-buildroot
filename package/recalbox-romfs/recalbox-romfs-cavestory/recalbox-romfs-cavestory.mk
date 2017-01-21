################################################################################
#
# recalbox-romfs-cavestory
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system cavestory --extension '.exe .EXE' --fullname 'Cave Story' --platform cavestory --theme cavestory libretro:nxengine:BR2_PACKAGE_LIBRETRO_NXENGINE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_CAVESTORY_SOURCE = 
RECALBOX_ROMFS_CAVESTORY_SITE = 
RECALBOX_ROMFS_CAVESTORY_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_CAVESTORY = cavestory
SYSTEM_XML_CAVESTORY = $(@D)/$(SYSTEM_NAME_CAVESTORY).xml
# System rom path
SOURCE_ROMDIR_CAVESTORY = $(RECALBOX_ROMFS_CAVESTORY_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_NXENGINE),)
define CONFIGURE_MAIN_CAVESTORY_START
	echo -e '<system>\n' \
	'\t<fullname>Cave Story</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_CAVESTORY)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_CAVESTORY)</path>\n' \
	'\t<extension>.exe .EXE</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>cavestory</platform>\n' \
	'\t<theme>cavestory</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_CAVESTORY)

endef
RECALBOX_ROMFS_CAVESTORY_CONFIGURE_CMDS += $(CONFIGURE_MAIN_CAVESTORY_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_NXENGINE),)
define CONFIGURE_CAVESTORY_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_CAVESTORY)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_CAVESTORY)

endef
RECALBOX_ROMFS_CAVESTORY_CONFIGURE_CMDS += $(CONFIGURE_CAVESTORY_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_NXENGINE),y)
define CONFIGURE_CAVESTORY_LIBRETRO_NXENGINE_DEF
	echo -e '\t\t\t\t<core>nxengine</core>' >> $(SYSTEM_XML_CAVESTORY)

endef
RECALBOX_ROMFS_CAVESTORY_CONFIGURE_CMDS += $(CONFIGURE_CAVESTORY_LIBRETRO_NXENGINE_DEF)
endif

define CONFIGURE_CAVESTORY_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_CAVESTORY)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_CAVESTORY)

endef
RECALBOX_ROMFS_CAVESTORY_CONFIGURE_CMDS += $(CONFIGURE_CAVESTORY_LIBRETRO_END)
endif



define CONFIGURE_MAIN_CAVESTORY_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_CAVESTORY)
	cp -R $(SOURCE_ROMDIR_CAVESTORY) $(@D)
endef
RECALBOX_ROMFS_CAVESTORY_CONFIGURE_CMDS += $(CONFIGURE_MAIN_CAVESTORY_END)
endif

$(eval $(generic-package))
