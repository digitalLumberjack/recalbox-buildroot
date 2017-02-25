################################################################################
#
# recalbox-romfs-lutro
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system lutro --extension '.zip .ZIP .lua .LUA .lutro .LUTRO' --fullname 'Lutro' --platform lutro --theme lutro libretro:lutro:BR2_PACKAGE_LIBRETRO_LUTRO

# Name the 3 vars as the package requires
RECALBOX_ROMFS_LUTRO_SOURCE = 
RECALBOX_ROMFS_LUTRO_SITE = 
RECALBOX_ROMFS_LUTRO_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_LUTRO = lutro
SYSTEM_XML_LUTRO = $(@D)/$(SYSTEM_NAME_LUTRO).xml
# System rom path
SOURCE_ROMDIR_LUTRO = $(RECALBOX_ROMFS_LUTRO_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_LUTRO),)
define CONFIGURE_MAIN_LUTRO_START
	echo -e '<system>\n' \
	'\t<fullname>Lutro</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_LUTRO)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_LUTRO)</path>\n' \
	'\t<extension>.zip .ZIP .lua .LUA .lutro .LUTRO</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>lutro</platform>\n' \
	'\t<theme>lutro</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_LUTRO)

endef
RECALBOX_ROMFS_LUTRO_CONFIGURE_CMDS += $(CONFIGURE_MAIN_LUTRO_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_LUTRO),)
define CONFIGURE_LUTRO_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_LUTRO)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_LUTRO)

endef
RECALBOX_ROMFS_LUTRO_CONFIGURE_CMDS += $(CONFIGURE_LUTRO_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_LUTRO),y)
define CONFIGURE_LUTRO_LIBRETRO_LUTRO_DEF
	echo -e '\t\t\t\t<core>lutro</core>' >> $(SYSTEM_XML_LUTRO)

endef
RECALBOX_ROMFS_LUTRO_CONFIGURE_CMDS += $(CONFIGURE_LUTRO_LIBRETRO_LUTRO_DEF)
endif

define CONFIGURE_LUTRO_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_LUTRO)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_LUTRO)

endef
RECALBOX_ROMFS_LUTRO_CONFIGURE_CMDS += $(CONFIGURE_LUTRO_LIBRETRO_END)
endif



define CONFIGURE_MAIN_LUTRO_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_LUTRO)
	cp -R $(SOURCE_ROMDIR_LUTRO) $(@D)
endef
RECALBOX_ROMFS_LUTRO_CONFIGURE_CMDS += $(CONFIGURE_MAIN_LUTRO_END)
endif

$(eval $(generic-package))
