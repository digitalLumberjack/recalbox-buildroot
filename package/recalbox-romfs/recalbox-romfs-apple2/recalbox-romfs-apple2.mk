################################################################################
#
# recalbox-romfs-apple2
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system apple2 --extension '.iso .ISO .gc .GC .gcz .GCZ' --fullname 'Apple II' --platform apple2 --theme apple2 BR2_PACKAGE_LINAPPLE_PIE

# Name the 3 vars as the package requires
RECALBOX_ROMFS_APPLE2_SOURCE = 
RECALBOX_ROMFS_APPLE2_SITE = 
RECALBOX_ROMFS_APPLE2_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_APPLE2 = apple2
SYSTEM_XML_APPLE2 = $(@D)/$(SYSTEM_NAME_APPLE2).xml
# System rom path
SOURCE_ROMDIR_APPLE2 = $(RECALBOX_ROMFS_APPLE2_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifeq ($(BR2_PACKAGE_LINAPPLE_PIE),y)
define CONFIGURE_APPLE2
	echo -e '<system>\n' \
	'\t<fullname>Apple II</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_APPLE2)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_APPLE2)</path>\n' \
	'\t<extension>.iso .ISO .gc .GC .gcz .GCZ</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>apple2</platform>\n' \
	'\t<theme>apple2</theme>\n' \
	'</system>' > $(SYSTEM_XML_APPLE2)
	cp -R $(SOURCE_ROMDIR_APPLE2) $(@D)
endef
RECALBOX_ROMFS_APPLE2_CONFIGURE_CMDS += $(CONFIGURE_APPLE2)
endif

$(eval $(generic-package))
