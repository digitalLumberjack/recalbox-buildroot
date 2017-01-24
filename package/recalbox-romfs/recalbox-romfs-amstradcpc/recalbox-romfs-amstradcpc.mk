################################################################################
#
# recalbox-romfs-amstradcpc
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system amstradcpc --extension '.dsk .DSK .zip .ZIP' --fullname 'AmstradCPC' --platform amstradcpc --theme amstradcpc libretro:cap32:BR2_PACKAGE_LIBRETRO_CAP32

# Name the 3 vars as the package requires
RECALBOX_ROMFS_AMSTRADCPC_SOURCE = 
RECALBOX_ROMFS_AMSTRADCPC_SITE = 
RECALBOX_ROMFS_AMSTRADCPC_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_AMSTRADCPC = amstradcpc
SYSTEM_XML_AMSTRADCPC = $(@D)/$(SYSTEM_NAME_AMSTRADCPC).xml
# System rom path
SOURCE_ROMDIR_AMSTRADCPC = $(RECALBOX_ROMFS_AMSTRADCPC_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_CAP32),)
define CONFIGURE_MAIN_AMSTRADCPC_START
	echo -e '<system>\n' \
	'\t<fullname>AmstradCPC</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_AMSTRADCPC)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_AMSTRADCPC)</path>\n' \
	'\t<extension>.dsk .DSK .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>amstradcpc</platform>\n' \
	'\t<theme>amstradcpc</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_AMSTRADCPC)

endef
RECALBOX_ROMFS_AMSTRADCPC_CONFIGURE_CMDS += $(CONFIGURE_MAIN_AMSTRADCPC_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_CAP32),)
define CONFIGURE_AMSTRADCPC_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_AMSTRADCPC)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_AMSTRADCPC)

endef
RECALBOX_ROMFS_AMSTRADCPC_CONFIGURE_CMDS += $(CONFIGURE_AMSTRADCPC_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_CAP32),y)
define CONFIGURE_AMSTRADCPC_LIBRETRO_CAP32_DEF
	echo -e '\t\t\t\t<core>cap32</core>' >> $(SYSTEM_XML_AMSTRADCPC)

endef
RECALBOX_ROMFS_AMSTRADCPC_CONFIGURE_CMDS += $(CONFIGURE_AMSTRADCPC_LIBRETRO_CAP32_DEF)
endif

define CONFIGURE_AMSTRADCPC_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_AMSTRADCPC)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_AMSTRADCPC)

endef
RECALBOX_ROMFS_AMSTRADCPC_CONFIGURE_CMDS += $(CONFIGURE_AMSTRADCPC_LIBRETRO_END)
endif



define CONFIGURE_MAIN_AMSTRADCPC_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_AMSTRADCPC)
	cp -R $(SOURCE_ROMDIR_AMSTRADCPC) $(@D)
endef
RECALBOX_ROMFS_AMSTRADCPC_CONFIGURE_CMDS += $(CONFIGURE_MAIN_AMSTRADCPC_END)
endif

$(eval $(generic-package))
