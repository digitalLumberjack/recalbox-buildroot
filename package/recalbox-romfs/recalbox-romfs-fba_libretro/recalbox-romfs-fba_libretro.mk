################################################################################
#
# recalbox-romfs-fba_libretro
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system fba_libretro --extension '.zip .ZIP .fba .FBA' --fullname 'FBA_LIBRETRO' --platform arcade --theme fba_libretro libretro:fba:BR2_PACKAGE_LIBRETRO_FBA

# Name the 3 vars as the package requires
RECALBOX_ROMFS_FBA_LIBRETRO_SOURCE = 
RECALBOX_ROMFS_FBA_LIBRETRO_SITE = 
RECALBOX_ROMFS_FBA_LIBRETRO_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_FBA_LIBRETRO = fba_libretro
SYSTEM_XML_FBA_LIBRETRO = $(@D)/$(SYSTEM_NAME_FBA_LIBRETRO).xml
# System rom path
SOURCE_ROMDIR_FBA_LIBRETRO = $(RECALBOX_ROMFS_FBA_LIBRETRO_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_FBA),)
define CONFIGURE_MAIN_FBA_LIBRETRO_START
	echo -e '<system>\n' \
	'\t<fullname>FBA_LIBRETRO</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_FBA_LIBRETRO)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_FBA_LIBRETRO)</path>\n' \
	'\t<extension>.zip .ZIP .fba .FBA</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>arcade</platform>\n' \
	'\t<theme>fba_libretro</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_FBA_LIBRETRO)

endef
RECALBOX_ROMFS_FBA_LIBRETRO_CONFIGURE_CMDS += $(CONFIGURE_MAIN_FBA_LIBRETRO_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_FBA),)
define CONFIGURE_FBA_LIBRETRO_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_FBA_LIBRETRO)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_FBA_LIBRETRO)

endef
RECALBOX_ROMFS_FBA_LIBRETRO_CONFIGURE_CMDS += $(CONFIGURE_FBA_LIBRETRO_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_FBA),y)
define CONFIGURE_FBA_LIBRETRO_LIBRETRO_FBA_DEF
	echo -e '\t\t\t\t<core>fba</core>' >> $(SYSTEM_XML_FBA_LIBRETRO)

endef
RECALBOX_ROMFS_FBA_LIBRETRO_CONFIGURE_CMDS += $(CONFIGURE_FBA_LIBRETRO_LIBRETRO_FBA_DEF)
endif

define CONFIGURE_FBA_LIBRETRO_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_FBA_LIBRETRO)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_FBA_LIBRETRO)

endef
RECALBOX_ROMFS_FBA_LIBRETRO_CONFIGURE_CMDS += $(CONFIGURE_FBA_LIBRETRO_LIBRETRO_END)
endif



define CONFIGURE_MAIN_FBA_LIBRETRO_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_FBA_LIBRETRO)
	cp -R $(SOURCE_ROMDIR_FBA_LIBRETRO) $(@D)
endef
RECALBOX_ROMFS_FBA_LIBRETRO_CONFIGURE_CMDS += $(CONFIGURE_MAIN_FBA_LIBRETRO_END)
endif

$(eval $(generic-package))
