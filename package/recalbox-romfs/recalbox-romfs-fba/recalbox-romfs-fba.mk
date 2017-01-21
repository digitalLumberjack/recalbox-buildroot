################################################################################
#
# recalbox-romfs-fba
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system fba --extension '.zip .ZIP .fba .FBA' --fullname 'Final Burn Alpha' --platform arcade --theme fba libretro:fba:BR2_PACKAGE_LIBRETRO_FBA fba2x:fba2x:BR2_PACKAGE_PIFBA

# Name the 3 vars as the package requires
RECALBOX_ROMFS_FBA_SOURCE = 
RECALBOX_ROMFS_FBA_SITE = 
RECALBOX_ROMFS_FBA_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_FBA = fba
SYSTEM_XML_FBA = $(@D)/$(SYSTEM_NAME_FBA).xml
# System rom path
SOURCE_ROMDIR_FBA = $(RECALBOX_ROMFS_FBA_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_LIBRETRO_FBA)$(BR2_PACKAGE_PIFBA),)
define CONFIGURE_MAIN_FBA_START
	echo -e '<system>\n' \
	'\t<fullname>Final Burn Alpha</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_FBA)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_FBA)</path>\n' \
	'\t<extension>.zip .ZIP .fba .FBA</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>arcade</platform>\n' \
	'\t<theme>fba</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_FBA)

endef
RECALBOX_ROMFS_FBA_CONFIGURE_CMDS += $(CONFIGURE_MAIN_FBA_START)


ifneq ($(BR2_PACKAGE_LIBRETRO_FBA)$(BR2_PACKAGE_PIFBA),)
define CONFIGURE_FBA_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_FBA)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_FBA)

endef
RECALBOX_ROMFS_FBA_CONFIGURE_CMDS += $(CONFIGURE_FBA_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_FBA),y)
define CONFIGURE_FBA_LIBRETRO_FBA_DEF
	echo -e '\t\t\t\t<core>fba</core>' >> $(SYSTEM_XML_FBA)

endef
RECALBOX_ROMFS_FBA_CONFIGURE_CMDS += $(CONFIGURE_FBA_LIBRETRO_FBA_DEF)
endif

define CONFIGURE_FBA_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_FBA)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_FBA)

endef
RECALBOX_ROMFS_FBA_CONFIGURE_CMDS += $(CONFIGURE_FBA_LIBRETRO_END)
endif

ifneq ($(BR2_PACKAGE_LIBRETRO_FBA)$(BR2_PACKAGE_PIFBA),)
define CONFIGURE_FBA_FBA2X_START
	echo -e '\t\t<emulator name="fba2x">' >> $(SYSTEM_XML_FBA)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_FBA)

endef
RECALBOX_ROMFS_FBA_CONFIGURE_CMDS += $(CONFIGURE_FBA_FBA2X_START)

ifeq ($(BR2_PACKAGE_PIFBA),y)
define CONFIGURE_FBA_FBA2X_FBA2X_DEF
	echo -e '\t\t\t\t<core>fba2x</core>' >> $(SYSTEM_XML_FBA)

endef
RECALBOX_ROMFS_FBA_CONFIGURE_CMDS += $(CONFIGURE_FBA_FBA2X_FBA2X_DEF)
endif

define CONFIGURE_FBA_FBA2X_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_FBA)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_FBA)

endef
RECALBOX_ROMFS_FBA_CONFIGURE_CMDS += $(CONFIGURE_FBA_FBA2X_END)
endif



define CONFIGURE_MAIN_FBA_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_FBA)
	cp -R $(SOURCE_ROMDIR_FBA) $(@D)
endef
RECALBOX_ROMFS_FBA_CONFIGURE_CMDS += $(CONFIGURE_MAIN_FBA_END)
endif

$(eval $(generic-package))
