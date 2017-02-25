################################################################################
#
# recalbox-romfs-nes
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system nes --extension '.nes .NES .zip .ZIP' --fullname 'Nintendo Entertainment System' --platform nes --theme nes libretro:fceumm:BR2_PACKAGE_LIBRETRO_FCEUMM libretro:fceunext:BR2_PACKAGE_LIBRETRO_FCEUNEXT libretro:nestopia:BR2_PACKAGE_LIBRETRO_NESTOPIA libretro:quicknes:BR2_PACKAGE_LIBRETRO_QUICKNES

# Name the 3 vars as the package requires
RECALBOX_ROMFS_NES_SOURCE = 
RECALBOX_ROMFS_NES_SITE = 
RECALBOX_ROMFS_NES_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_NES = nes
SYSTEM_XML_NES = $(@D)/$(SYSTEM_NAME_NES).xml
# System rom path
SOURCE_ROMDIR_NES = $(RECALBOX_ROMFS_NES_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_FCEUMM)$(BR2_PACKAGE_LIBRETRO_FCEUNEXT)$(BR2_PACKAGE_LIBRETRO_NESTOPIA)$(BR2_PACKAGE_LIBRETRO_QUICKNES),)
define CONFIGURE_MAIN_NES_START
	echo -e '<system>\n' \
	'\t<fullname>Nintendo Entertainment System</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_NES)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_NES)</path>\n' \
	'\t<extension>.nes .NES .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>nes</platform>\n' \
	'\t<theme>nes</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_NES)

endef
RECALBOX_ROMFS_NES_CONFIGURE_CMDS += $(CONFIGURE_MAIN_NES_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_FCEUMM)$(BR2_PACKAGE_LIBRETRO_FCEUNEXT)$(BR2_PACKAGE_LIBRETRO_NESTOPIA)$(BR2_PACKAGE_LIBRETRO_QUICKNES),)
define CONFIGURE_NES_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_NES)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_NES)

endef
RECALBOX_ROMFS_NES_CONFIGURE_CMDS += $(CONFIGURE_NES_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_FCEUNEXT),y)
define CONFIGURE_NES_LIBRETRO_FCEUNEXT_DEF
	echo -e '\t\t\t\t<core>fceunext</core>' >> $(SYSTEM_XML_NES)

endef
RECALBOX_ROMFS_NES_CONFIGURE_CMDS += $(CONFIGURE_NES_LIBRETRO_FCEUNEXT_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_QUICKNES),y)
define CONFIGURE_NES_LIBRETRO_QUICKNES_DEF
	echo -e '\t\t\t\t<core>quicknes</core>' >> $(SYSTEM_XML_NES)

endef
RECALBOX_ROMFS_NES_CONFIGURE_CMDS += $(CONFIGURE_NES_LIBRETRO_QUICKNES_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_FCEUMM),y)
define CONFIGURE_NES_LIBRETRO_FCEUMM_DEF
	echo -e '\t\t\t\t<core>fceumm</core>' >> $(SYSTEM_XML_NES)

endef
RECALBOX_ROMFS_NES_CONFIGURE_CMDS += $(CONFIGURE_NES_LIBRETRO_FCEUMM_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_NESTOPIA),y)
define CONFIGURE_NES_LIBRETRO_NESTOPIA_DEF
	echo -e '\t\t\t\t<core>nestopia</core>' >> $(SYSTEM_XML_NES)

endef
RECALBOX_ROMFS_NES_CONFIGURE_CMDS += $(CONFIGURE_NES_LIBRETRO_NESTOPIA_DEF)
endif

define CONFIGURE_NES_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_NES)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_NES)

endef
RECALBOX_ROMFS_NES_CONFIGURE_CMDS += $(CONFIGURE_NES_LIBRETRO_END)
endif



define CONFIGURE_MAIN_NES_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_NES)
	cp -R $(SOURCE_ROMDIR_NES) $(@D)
endef
RECALBOX_ROMFS_NES_CONFIGURE_CMDS += $(CONFIGURE_MAIN_NES_END)
endif

$(eval $(generic-package))
