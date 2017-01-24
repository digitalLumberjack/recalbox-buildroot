################################################################################
#
# recalbox-romfs-supergrafx
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system supergrafx --extension '.pce .PCE .sgx .SGX .zip .ZIP' --fullname 'Supergrafx' --platform supergrafx --theme supergrafx libretro:mednafen_supergrafx:BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX libretro:pce:BR2_PACKAGE_LIBRETRO_BEETLE_PCE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_SUPERGRAFX_SOURCE = 
RECALBOX_ROMFS_SUPERGRAFX_SITE = 
RECALBOX_ROMFS_SUPERGRAFX_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_SUPERGRAFX = supergrafx
SYSTEM_XML_SUPERGRAFX = $(@D)/$(SYSTEM_NAME_SUPERGRAFX).xml
# System rom path
SOURCE_ROMDIR_SUPERGRAFX = $(RECALBOX_ROMFS_SUPERGRAFX_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
define CONFIGURE_MAIN_SUPERGRAFX_START
	echo -e '<system>\n' \
	'\t<fullname>Supergrafx</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_SUPERGRAFX)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_SUPERGRAFX)</path>\n' \
	'\t<extension>.pce .PCE .sgx .SGX .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>supergrafx</platform>\n' \
	'\t<theme>supergrafx</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_SUPERGRAFX)

endef
RECALBOX_ROMFS_SUPERGRAFX_CONFIGURE_CMDS += $(CONFIGURE_MAIN_SUPERGRAFX_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
define CONFIGURE_SUPERGRAFX_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_SUPERGRAFX)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_SUPERGRAFX)

endef
RECALBOX_ROMFS_SUPERGRAFX_CONFIGURE_CMDS += $(CONFIGURE_SUPERGRAFX_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX),y)
define CONFIGURE_SUPERGRAFX_LIBRETRO_MEDNAFEN_SUPERGRAFX_DEF
	echo -e '\t\t\t\t<core>mednafen_supergrafx</core>' >> $(SYSTEM_XML_SUPERGRAFX)

endef
RECALBOX_ROMFS_SUPERGRAFX_CONFIGURE_CMDS += $(CONFIGURE_SUPERGRAFX_LIBRETRO_MEDNAFEN_SUPERGRAFX_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),y)
define CONFIGURE_SUPERGRAFX_LIBRETRO_PCE_DEF
	echo -e '\t\t\t\t<core>pce</core>' >> $(SYSTEM_XML_SUPERGRAFX)

endef
RECALBOX_ROMFS_SUPERGRAFX_CONFIGURE_CMDS += $(CONFIGURE_SUPERGRAFX_LIBRETRO_PCE_DEF)
endif

define CONFIGURE_SUPERGRAFX_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_SUPERGRAFX)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_SUPERGRAFX)

endef
RECALBOX_ROMFS_SUPERGRAFX_CONFIGURE_CMDS += $(CONFIGURE_SUPERGRAFX_LIBRETRO_END)
endif



define CONFIGURE_MAIN_SUPERGRAFX_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_SUPERGRAFX)
	cp -R $(SOURCE_ROMDIR_SUPERGRAFX) $(@D)
endef
RECALBOX_ROMFS_SUPERGRAFX_CONFIGURE_CMDS += $(CONFIGURE_MAIN_SUPERGRAFX_END)
endif

$(eval $(generic-package))
