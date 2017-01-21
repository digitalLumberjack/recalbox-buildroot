################################################################################
#
# recalbox-romfs-snes
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system snes --extension '.smc .sfc .SMC .SFC .zip .ZIP .mgd .MGD' --fullname 'Super Nintendo Entertainment System' --platform snes --theme snes libretro:catsfc:BR2_PACKAGE_LIBRETRO_CATSFC libretro:pocketsnes:BR2_PACKAGE_LIBRETRO_POCKETSNES libretro:snes9x_next:BR2_PACKAGE_LIBRETRO_SNES9X_NEXT

# Name the 3 vars as the package requires
RECALBOX_ROMFS_SNES_SOURCE = 
RECALBOX_ROMFS_SNES_SITE = 
RECALBOX_ROMFS_SNES_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_SNES = snes
SYSTEM_XML_SNES = $(@D)/$(SYSTEM_NAME_SNES).xml
# System rom path
SOURCE_ROMDIR_SNES = $(RECALBOX_ROMFS_SNES_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_CATSFC)$(BR2_PACKAGE_LIBRETRO_POCKETSNES)$(BR2_PACKAGE_LIBRETRO_SNES9X_NEXT),)
define CONFIGURE_MAIN_SNES_START
	echo -e '<system>\n' \
	'\t<fullname>Super Nintendo Entertainment System</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_SNES)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_SNES)</path>\n' \
	'\t<extension>.smc .sfc .SMC .SFC .zip .ZIP .mgd .MGD</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>snes</platform>\n' \
	'\t<theme>snes</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_SNES)

endef
RECALBOX_ROMFS_SNES_CONFIGURE_CMDS += $(CONFIGURE_MAIN_SNES_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_CATSFC)$(BR2_PACKAGE_LIBRETRO_POCKETSNES)$(BR2_PACKAGE_LIBRETRO_SNES9X_NEXT),)
define CONFIGURE_SNES_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_SNES)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_SNES)

endef
RECALBOX_ROMFS_SNES_CONFIGURE_CMDS += $(CONFIGURE_SNES_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_SNES9X_NEXT),y)
define CONFIGURE_SNES_LIBRETRO_SNES9X_NEXT_DEF
	echo -e '\t\t\t\t<core>snes9x_next</core>' >> $(SYSTEM_XML_SNES)

endef
RECALBOX_ROMFS_SNES_CONFIGURE_CMDS += $(CONFIGURE_SNES_LIBRETRO_SNES9X_NEXT_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_CATSFC),y)
define CONFIGURE_SNES_LIBRETRO_CATSFC_DEF
	echo -e '\t\t\t\t<core>catsfc</core>' >> $(SYSTEM_XML_SNES)

endef
RECALBOX_ROMFS_SNES_CONFIGURE_CMDS += $(CONFIGURE_SNES_LIBRETRO_CATSFC_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_POCKETSNES),y)
define CONFIGURE_SNES_LIBRETRO_POCKETSNES_DEF
	echo -e '\t\t\t\t<core>pocketsnes</core>' >> $(SYSTEM_XML_SNES)

endef
RECALBOX_ROMFS_SNES_CONFIGURE_CMDS += $(CONFIGURE_SNES_LIBRETRO_POCKETSNES_DEF)
endif

define CONFIGURE_SNES_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_SNES)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_SNES)

endef
RECALBOX_ROMFS_SNES_CONFIGURE_CMDS += $(CONFIGURE_SNES_LIBRETRO_END)
endif



define CONFIGURE_MAIN_SNES_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_SNES)
	cp -R $(SOURCE_ROMDIR_SNES) $(@D)
endef
RECALBOX_ROMFS_SNES_CONFIGURE_CMDS += $(CONFIGURE_MAIN_SNES_END)
endif

$(eval $(generic-package))
