################################################################################
#
# recalbox-romfs-pcenginecd
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system pcenginecd --extension '.cue .CUE .ccd .CCD' --fullname 'PC Engine CD' --platform pcenginecd --theme pcenginecd libretro:mednafen_supergrafx:BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX libretro:pce:BR2_PACKAGE_LIBRETRO_BEETLE_PCE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_PCENGINECD_SOURCE = 
RECALBOX_ROMFS_PCENGINECD_SITE = 
RECALBOX_ROMFS_PCENGINECD_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_PCENGINECD = pcenginecd
SYSTEM_XML_PCENGINECD = $(@D)/$(SYSTEM_NAME_PCENGINECD).xml
# System rom path
SOURCE_ROMDIR_PCENGINECD = $(RECALBOX_ROMFS_PCENGINECD_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
define CONFIGURE_MAIN_PCENGINECD_START
	echo -e '<system>\n' \
	'\t<fullname>PC Engine CD</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_PCENGINECD)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_PCENGINECD)</path>\n' \
	'\t<extension>.cue .CUE .ccd .CCD</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>pcenginecd</platform>\n' \
	'\t<theme>pcenginecd</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_PCENGINECD)

endef
RECALBOX_ROMFS_PCENGINECD_CONFIGURE_CMDS += $(CONFIGURE_MAIN_PCENGINECD_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
define CONFIGURE_PCENGINECD_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_PCENGINECD)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_PCENGINECD)

endef
RECALBOX_ROMFS_PCENGINECD_CONFIGURE_CMDS += $(CONFIGURE_PCENGINECD_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX),y)
define CONFIGURE_PCENGINECD_LIBRETRO_MEDNAFEN_SUPERGRAFX_DEF
	echo -e '\t\t\t\t<core>mednafen_supergrafx</core>' >> $(SYSTEM_XML_PCENGINECD)

endef
RECALBOX_ROMFS_PCENGINECD_CONFIGURE_CMDS += $(CONFIGURE_PCENGINECD_LIBRETRO_MEDNAFEN_SUPERGRAFX_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),y)
define CONFIGURE_PCENGINECD_LIBRETRO_PCE_DEF
	echo -e '\t\t\t\t<core>pce</core>' >> $(SYSTEM_XML_PCENGINECD)

endef
RECALBOX_ROMFS_PCENGINECD_CONFIGURE_CMDS += $(CONFIGURE_PCENGINECD_LIBRETRO_PCE_DEF)
endif

define CONFIGURE_PCENGINECD_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_PCENGINECD)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_PCENGINECD)

endef
RECALBOX_ROMFS_PCENGINECD_CONFIGURE_CMDS += $(CONFIGURE_PCENGINECD_LIBRETRO_END)
endif



define CONFIGURE_MAIN_PCENGINECD_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_PCENGINECD)
	cp -R $(SOURCE_ROMDIR_PCENGINECD) $(@D)
endef
RECALBOX_ROMFS_PCENGINECD_CONFIGURE_CMDS += $(CONFIGURE_MAIN_PCENGINECD_END)
endif

$(eval $(generic-package))
