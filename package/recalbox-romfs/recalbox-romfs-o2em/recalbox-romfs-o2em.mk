################################################################################
#
# recalbox-romfs-o2em
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system o2em --extension '.bin .BIN .zip .ZIP' --fullname 'Odyssey2' --platform odyssey2 --theme odyssey2 libretro:o2em:BR2_PACKAGE_LIBRETRO_O2EM

# Name the 3 vars as the package requires
RECALBOX_ROMFS_O2EM_SOURCE = 
RECALBOX_ROMFS_O2EM_SITE = 
RECALBOX_ROMFS_O2EM_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_O2EM = o2em
SYSTEM_XML_O2EM = $(@D)/$(SYSTEM_NAME_O2EM).xml
# System rom path
SOURCE_ROMDIR_O2EM = $(RECALBOX_ROMFS_O2EM_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_O2EM),)
define CONFIGURE_MAIN_O2EM_START
	echo -e '<system>\n' \
	'\t<fullname>Odyssey2</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_O2EM)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_O2EM)</path>\n' \
	'\t<extension>.bin .BIN .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>odyssey2</platform>\n' \
	'\t<theme>odyssey2</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_O2EM)

endef
RECALBOX_ROMFS_O2EM_CONFIGURE_CMDS += $(CONFIGURE_MAIN_O2EM_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_O2EM),)
define CONFIGURE_O2EM_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_O2EM)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_O2EM)

endef
RECALBOX_ROMFS_O2EM_CONFIGURE_CMDS += $(CONFIGURE_O2EM_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_O2EM),y)
define CONFIGURE_O2EM_LIBRETRO_O2EM_DEF
	echo -e '\t\t\t\t<core>o2em</core>' >> $(SYSTEM_XML_O2EM)

endef
RECALBOX_ROMFS_O2EM_CONFIGURE_CMDS += $(CONFIGURE_O2EM_LIBRETRO_O2EM_DEF)
endif

define CONFIGURE_O2EM_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_O2EM)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_O2EM)

endef
RECALBOX_ROMFS_O2EM_CONFIGURE_CMDS += $(CONFIGURE_O2EM_LIBRETRO_END)
endif



define CONFIGURE_MAIN_O2EM_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_O2EM)
	cp -R $(SOURCE_ROMDIR_O2EM) $(@D)
endef
RECALBOX_ROMFS_O2EM_CONFIGURE_CMDS += $(CONFIGURE_MAIN_O2EM_END)
endif

$(eval $(generic-package))
