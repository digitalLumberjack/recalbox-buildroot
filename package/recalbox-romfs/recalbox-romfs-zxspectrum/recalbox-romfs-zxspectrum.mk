################################################################################
#
# recalbox-romfs-zxspectrum
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system zxspectrum --extension '.tzx .TZX .tap .TAP .z80 .ZX80 .rzx .RZX .scl .SCL .trd .TRD .zip .ZIP' --fullname 'ZXSpectrum' --platform zxspectrum --theme zxspectrum libretro:fuse:BR2_PACKAGE_LIBRETRO_FUSE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_ZXSPECTRUM_SOURCE = 
RECALBOX_ROMFS_ZXSPECTRUM_SITE = 
RECALBOX_ROMFS_ZXSPECTRUM_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_ZXSPECTRUM = zxspectrum
SYSTEM_XML_ZXSPECTRUM = $(@D)/$(SYSTEM_NAME_ZXSPECTRUM).xml
# System rom path
SOURCE_ROMDIR_ZXSPECTRUM = $(RECALBOX_ROMFS_ZXSPECTRUM_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_FUSE),)
define CONFIGURE_MAIN_ZXSPECTRUM_START
	echo -e '<system>\n' \
	'\t<fullname>ZXSpectrum</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_ZXSPECTRUM)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_ZXSPECTRUM)</path>\n' \
	'\t<extension>.tzx .TZX .tap .TAP .z80 .ZX80 .rzx .RZX .scl .SCL .trd .TRD .zip .ZIP</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>zxspectrum</platform>\n' \
	'\t<theme>zxspectrum</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_ZXSPECTRUM)

endef
RECALBOX_ROMFS_ZXSPECTRUM_CONFIGURE_CMDS += $(CONFIGURE_MAIN_ZXSPECTRUM_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_FUSE),)
define CONFIGURE_ZXSPECTRUM_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_ZXSPECTRUM)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_ZXSPECTRUM)

endef
RECALBOX_ROMFS_ZXSPECTRUM_CONFIGURE_CMDS += $(CONFIGURE_ZXSPECTRUM_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_FUSE),y)
define CONFIGURE_ZXSPECTRUM_LIBRETRO_FUSE_DEF
	echo -e '\t\t\t\t<core>fuse</core>' >> $(SYSTEM_XML_ZXSPECTRUM)

endef
RECALBOX_ROMFS_ZXSPECTRUM_CONFIGURE_CMDS += $(CONFIGURE_ZXSPECTRUM_LIBRETRO_FUSE_DEF)
endif

define CONFIGURE_ZXSPECTRUM_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_ZXSPECTRUM)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_ZXSPECTRUM)

endef
RECALBOX_ROMFS_ZXSPECTRUM_CONFIGURE_CMDS += $(CONFIGURE_ZXSPECTRUM_LIBRETRO_END)
endif



define CONFIGURE_MAIN_ZXSPECTRUM_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_ZXSPECTRUM)
	cp -R $(SOURCE_ROMDIR_ZXSPECTRUM) $(@D)
endef
RECALBOX_ROMFS_ZXSPECTRUM_CONFIGURE_CMDS += $(CONFIGURE_MAIN_ZXSPECTRUM_END)
endif

$(eval $(generic-package))
