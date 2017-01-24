################################################################################
#
# recalbox-romfs-vectrex
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system vectrex --extension '.zip .ZIP .vec .VEC' --fullname 'Vectrex' --platform vectrex --theme vectrex libretro:vecx:BR2_PACKAGE_LIBRETRO_VECX

# Name the 3 vars as the package requires
RECALBOX_ROMFS_VECTREX_SOURCE = 
RECALBOX_ROMFS_VECTREX_SITE = 
RECALBOX_ROMFS_VECTREX_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_VECTREX = vectrex
SYSTEM_XML_VECTREX = $(@D)/$(SYSTEM_NAME_VECTREX).xml
# System rom path
SOURCE_ROMDIR_VECTREX = $(RECALBOX_ROMFS_VECTREX_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_VECX),)
define CONFIGURE_MAIN_VECTREX_START
	echo -e '<system>\n' \
	'\t<fullname>Vectrex</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_VECTREX)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_VECTREX)</path>\n' \
	'\t<extension>.zip .ZIP .vec .VEC</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>vectrex</platform>\n' \
	'\t<theme>vectrex</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_VECTREX)

endef
RECALBOX_ROMFS_VECTREX_CONFIGURE_CMDS += $(CONFIGURE_MAIN_VECTREX_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_VECX),)
define CONFIGURE_VECTREX_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_VECTREX)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_VECTREX)

endef
RECALBOX_ROMFS_VECTREX_CONFIGURE_CMDS += $(CONFIGURE_VECTREX_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_VECX),y)
define CONFIGURE_VECTREX_LIBRETRO_VECX_DEF
	echo -e '\t\t\t\t<core>vecx</core>' >> $(SYSTEM_XML_VECTREX)

endef
RECALBOX_ROMFS_VECTREX_CONFIGURE_CMDS += $(CONFIGURE_VECTREX_LIBRETRO_VECX_DEF)
endif

define CONFIGURE_VECTREX_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_VECTREX)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_VECTREX)

endef
RECALBOX_ROMFS_VECTREX_CONFIGURE_CMDS += $(CONFIGURE_VECTREX_LIBRETRO_END)
endif



define CONFIGURE_MAIN_VECTREX_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_VECTREX)
	cp -R $(SOURCE_ROMDIR_VECTREX) $(@D)
endef
RECALBOX_ROMFS_VECTREX_CONFIGURE_CMDS += $(CONFIGURE_MAIN_VECTREX_END)
endif

$(eval $(generic-package))
