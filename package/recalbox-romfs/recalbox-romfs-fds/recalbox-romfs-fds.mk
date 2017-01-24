################################################################################
#
# recalbox-romfs-fds
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system fds --extension '.fds .FDS .zip .ZIP' --fullname 'Family Computer Disk System' --platform fds --theme fds libretro:fceumm:BR2_PACKAGE_LIBRETRO_FCEUMM libretro:nestopia:BR2_PACKAGE_LIBRETRO_NESTOPIA

# Name the 3 vars as the package requires
RECALBOX_ROMFS_FDS_SOURCE = 
RECALBOX_ROMFS_FDS_SITE = 
RECALBOX_ROMFS_FDS_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_FDS = fds
SYSTEM_XML_FDS = $(@D)/$(SYSTEM_NAME_FDS).xml
# System rom path
SOURCE_ROMDIR_FDS = $(RECALBOX_ROMFS_FDS_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_FCEUMM)$(BR2_PACKAGE_LIBRETRO_NESTOPIA),)
define CONFIGURE_MAIN_FDS_START
	echo -e '<system>\n' \
	'\t<fullname>Family Computer Disk System</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_FDS)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_FDS)</path>\n' \
	'\t<extension>.fds .FDS .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>fds</platform>\n' \
	'\t<theme>fds</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_FDS)

endef
RECALBOX_ROMFS_FDS_CONFIGURE_CMDS += $(CONFIGURE_MAIN_FDS_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_FCEUMM)$(BR2_PACKAGE_LIBRETRO_NESTOPIA),)
define CONFIGURE_FDS_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_FDS)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_FDS)

endef
RECALBOX_ROMFS_FDS_CONFIGURE_CMDS += $(CONFIGURE_FDS_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_FCEUMM),y)
define CONFIGURE_FDS_LIBRETRO_FCEUMM_DEF
	echo -e '\t\t\t\t<core>fceumm</core>' >> $(SYSTEM_XML_FDS)

endef
RECALBOX_ROMFS_FDS_CONFIGURE_CMDS += $(CONFIGURE_FDS_LIBRETRO_FCEUMM_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_NESTOPIA),y)
define CONFIGURE_FDS_LIBRETRO_NESTOPIA_DEF
	echo -e '\t\t\t\t<core>nestopia</core>' >> $(SYSTEM_XML_FDS)

endef
RECALBOX_ROMFS_FDS_CONFIGURE_CMDS += $(CONFIGURE_FDS_LIBRETRO_NESTOPIA_DEF)
endif

define CONFIGURE_FDS_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_FDS)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_FDS)

endef
RECALBOX_ROMFS_FDS_CONFIGURE_CMDS += $(CONFIGURE_FDS_LIBRETRO_END)
endif



define CONFIGURE_MAIN_FDS_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_FDS)
	cp -R $(SOURCE_ROMDIR_FDS) $(@D)
endef
RECALBOX_ROMFS_FDS_CONFIGURE_CMDS += $(CONFIGURE_MAIN_FDS_END)
endif

$(eval $(generic-package))
