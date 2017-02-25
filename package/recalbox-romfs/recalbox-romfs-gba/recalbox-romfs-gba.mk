################################################################################
#
# recalbox-romfs-gba
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system gba --extension '.gba .GBA .zip .ZIP' --fullname 'Game Boy Advance' --platform gba --theme gba libretro:gpsp:BR2_PACKAGE_LIBRETRO_GPSP libretro:mgba:BR2_PACKAGE_LIBRETRO_MGBA libretro:meteor:BR2_PACKAGE_LIBRETRO_METEOR

# Name the 3 vars as the package requires
RECALBOX_ROMFS_GBA_SOURCE = 
RECALBOX_ROMFS_GBA_SITE = 
RECALBOX_ROMFS_GBA_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_GBA = gba
SYSTEM_XML_GBA = $(@D)/$(SYSTEM_NAME_GBA).xml
# System rom path
SOURCE_ROMDIR_GBA = $(RECALBOX_ROMFS_GBA_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_GPSP)$(BR2_PACKAGE_LIBRETRO_MGBA)$(BR2_PACKAGE_LIBRETRO_METEOR),)
define CONFIGURE_MAIN_GBA_START
	echo -e '<system>\n' \
	'\t<fullname>Game Boy Advance</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_GBA)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_GBA)</path>\n' \
	'\t<extension>.gba .GBA .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>gba</platform>\n' \
	'\t<theme>gba</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_GBA)

endef
RECALBOX_ROMFS_GBA_CONFIGURE_CMDS += $(CONFIGURE_MAIN_GBA_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_GPSP)$(BR2_PACKAGE_LIBRETRO_MGBA)$(BR2_PACKAGE_LIBRETRO_METEOR),)
define CONFIGURE_GBA_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_GBA)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_GBA)

endef
RECALBOX_ROMFS_GBA_CONFIGURE_CMDS += $(CONFIGURE_GBA_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_GPSP),y)
define CONFIGURE_GBA_LIBRETRO_GPSP_DEF
	echo -e '\t\t\t\t<core>gpsp</core>' >> $(SYSTEM_XML_GBA)

endef
RECALBOX_ROMFS_GBA_CONFIGURE_CMDS += $(CONFIGURE_GBA_LIBRETRO_GPSP_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_MGBA),y)
define CONFIGURE_GBA_LIBRETRO_MGBA_DEF
	echo -e '\t\t\t\t<core>mgba</core>' >> $(SYSTEM_XML_GBA)

endef
RECALBOX_ROMFS_GBA_CONFIGURE_CMDS += $(CONFIGURE_GBA_LIBRETRO_MGBA_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_METEOR),y)
define CONFIGURE_GBA_LIBRETRO_METEOR_DEF
	echo -e '\t\t\t\t<core>meteor</core>' >> $(SYSTEM_XML_GBA)

endef
RECALBOX_ROMFS_GBA_CONFIGURE_CMDS += $(CONFIGURE_GBA_LIBRETRO_METEOR_DEF)
endif

define CONFIGURE_GBA_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_GBA)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_GBA)

endef
RECALBOX_ROMFS_GBA_CONFIGURE_CMDS += $(CONFIGURE_GBA_LIBRETRO_END)
endif



define CONFIGURE_MAIN_GBA_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_GBA)
	cp -R $(SOURCE_ROMDIR_GBA) $(@D)
endef
RECALBOX_ROMFS_GBA_CONFIGURE_CMDS += $(CONFIGURE_MAIN_GBA_END)
endif

$(eval $(generic-package))
