################################################################################
#
# recalbox-romfs-pcengine
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system pcengine --extension '.pce .PCE .cue .CUE .sgx .SGX .zip .ZIP .ccd .CCD' --fullname 'PC Engine' --platform pcengine --theme pcengine libretro:mednafen_supergrafx:BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX libretro:pce:BR2_PACKAGE_LIBRETRO_BEETLE_PCE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_PCENGINE_SOURCE = 
RECALBOX_ROMFS_PCENGINE_SITE = 
RECALBOX_ROMFS_PCENGINE_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_PCENGINE = pcengine
SYSTEM_XML_PCENGINE = $(@D)/$(SYSTEM_NAME_PCENGINE).xml
# System rom path
SOURCE_ROMDIR_PCENGINE = $(RECALBOX_ROMFS_PCENGINE_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
define CONFIGURE_MAIN_PCENGINE_START
	echo -e '<system>\n' \
	'\t<fullname>PC Engine</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_PCENGINE)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_PCENGINE)</path>\n' \
	'\t<extension>.pce .PCE .cue .CUE .sgx .SGX .zip .ZIP .ccd .CCD</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>pcengine</platform>\n' \
	'\t<theme>pcengine</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_PCENGINE)

endef
RECALBOX_ROMFS_PCENGINE_CONFIGURE_CMDS += $(CONFIGURE_MAIN_PCENGINE_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
define CONFIGURE_PCENGINE_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_PCENGINE)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_PCENGINE)

endef
RECALBOX_ROMFS_PCENGINE_CONFIGURE_CMDS += $(CONFIGURE_PCENGINE_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX),y)
define CONFIGURE_PCENGINE_LIBRETRO_MEDNAFEN_SUPERGRAFX_DEF
	echo -e '\t\t\t\t<core>mednafen_supergrafx</core>' >> $(SYSTEM_XML_PCENGINE)

endef
RECALBOX_ROMFS_PCENGINE_CONFIGURE_CMDS += $(CONFIGURE_PCENGINE_LIBRETRO_MEDNAFEN_SUPERGRAFX_DEF)
endif

ifeq ($(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),y)
define CONFIGURE_PCENGINE_LIBRETRO_PCE_DEF
	echo -e '\t\t\t\t<core>pce</core>' >> $(SYSTEM_XML_PCENGINE)

endef
RECALBOX_ROMFS_PCENGINE_CONFIGURE_CMDS += $(CONFIGURE_PCENGINE_LIBRETRO_PCE_DEF)
endif

define CONFIGURE_PCENGINE_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_PCENGINE)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_PCENGINE)

endef
RECALBOX_ROMFS_PCENGINE_CONFIGURE_CMDS += $(CONFIGURE_PCENGINE_LIBRETRO_END)
endif



define CONFIGURE_MAIN_PCENGINE_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_PCENGINE)
	cp -R $(SOURCE_ROMDIR_PCENGINE) $(@D)
endef
RECALBOX_ROMFS_PCENGINE_CONFIGURE_CMDS += $(CONFIGURE_MAIN_PCENGINE_END)
endif

$(eval $(generic-package))
