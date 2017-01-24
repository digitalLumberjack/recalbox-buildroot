################################################################################
#
# recalbox-romfs-n64
#
################################################################################

# Package generated with :
# ./scripts/linux/empack.py --system n64 --extension '.n64 .N64 .z64 .Z64 .v64 .V64' --fullname 'Nintendo 64' --platform n64 --theme n64 mupen64plus:gliden64:BR2_PACKAGE_MUPEN64PLUS_GLIDEN64 mupen64plus:n64:BR2_PACKAGE_MUPEN64PLUS_GLES2 mupen64plus:rice:BR2_PACKAGE_MUPEN64PLUS_GLES2RICE mupen64plus:glide64mk2:BR2_PACKAGE_MUPEN64PLUS_VIDEO_GLIDE64MK2 libretro:glupen64:BR2_PACKAGE_LIBRETRO_GLUPEN64

# Name the 3 vars as the package requires
RECALBOX_ROMFS_N64_SOURCE = 
RECALBOX_ROMFS_N64_SITE = 
RECALBOX_ROMFS_N64_INSTALL_STAGING = NO
# Set the system name
SYSTEM_NAME_N64 = n64
SYSTEM_XML_N64 = $(@D)/$(SYSTEM_NAME_N64).xml
# System rom path
SOURCE_ROMDIR_N64 = $(RECALBOX_ROMFS_N64_PKGDIR)/roms

# CONFIGGEN_STD_CMD is defined in recalbox-romfs, so take good care that
# variables are global across buildroot


ifneq ($(BR2_PACKAGE_MUPEN64PLUS_GLIDEN64)$(BR2_PACKAGE_MUPEN64PLUS_GLES2)$(BR2_PACKAGE_MUPEN64PLUS_GLES2RICE)$(BR2_PACKAGE_MUPEN64PLUS_VIDEO_GLIDE64MK2)$(BR2_PACKAGE_LIBRETRO_GLUPEN64),)
define CONFIGURE_MAIN_N64_START
	echo -e '<system>\n' \
	'\t<fullname>Nintendo 64</fullname>\n' \
	"\t<name>$(SYSTEM_NAME_N64)</name>\n" \
	'\t<path>/recalbox/share/roms/$(SYSTEM_NAME_N64)</path>\n' \
	'\t<extension>.n64 .N64 .z64 .Z64 .v64 .V64</extension>\n' \
	"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
	'\t<platform>n64</platform>\n' \
	'\t<theme>n64</theme>\n' \
	'\t<emulators>' > $(SYSTEM_XML_N64)

endef
RECALBOX_ROMFS_N64_CONFIGURE_CMDS += $(CONFIGURE_MAIN_N64_START)


ifneq ($(BR2_PACKAGE_MUPEN64PLUS_GLIDEN64)$(BR2_PACKAGE_MUPEN64PLUS_GLES2)$(BR2_PACKAGE_MUPEN64PLUS_GLES2RICE)$(BR2_PACKAGE_MUPEN64PLUS_VIDEO_GLIDE64MK2)$(BR2_PACKAGE_LIBRETRO_GLUPEN64),)
define CONFIGURE_N64_LIBRETRO_START
	echo -e '\t\t<emulator name="libretro">' >> $(SYSTEM_XML_N64)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_N64)

endef
RECALBOX_ROMFS_N64_CONFIGURE_CMDS += $(CONFIGURE_N64_LIBRETRO_START)

ifeq ($(BR2_PACKAGE_LIBRETRO_GLUPEN64),y)
define CONFIGURE_N64_LIBRETRO_GLUPEN64_DEF
	echo -e '\t\t\t\t<core>glupen64</core>' >> $(SYSTEM_XML_N64)

endef
RECALBOX_ROMFS_N64_CONFIGURE_CMDS += $(CONFIGURE_N64_LIBRETRO_GLUPEN64_DEF)
endif

define CONFIGURE_N64_LIBRETRO_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_N64)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_N64)

endef
RECALBOX_ROMFS_N64_CONFIGURE_CMDS += $(CONFIGURE_N64_LIBRETRO_END)
endif

ifneq ($(BR2_PACKAGE_MUPEN64PLUS_GLIDEN64)$(BR2_PACKAGE_MUPEN64PLUS_GLES2)$(BR2_PACKAGE_MUPEN64PLUS_GLES2RICE)$(BR2_PACKAGE_MUPEN64PLUS_VIDEO_GLIDE64MK2)$(BR2_PACKAGE_LIBRETRO_GLUPEN64),)
define CONFIGURE_N64_MUPEN64PLUS_START
	echo -e '\t\t<emulator name="mupen64plus">' >> $(SYSTEM_XML_N64)
	echo -e '\t\t\t<cores>' >> $(SYSTEM_XML_N64)

endef
RECALBOX_ROMFS_N64_CONFIGURE_CMDS += $(CONFIGURE_N64_MUPEN64PLUS_START)

ifeq ($(BR2_PACKAGE_MUPEN64PLUS_GLES2RICE),y)
define CONFIGURE_N64_MUPEN64PLUS_RICE_DEF
	echo -e '\t\t\t\t<core>rice</core>' >> $(SYSTEM_XML_N64)

endef
RECALBOX_ROMFS_N64_CONFIGURE_CMDS += $(CONFIGURE_N64_MUPEN64PLUS_RICE_DEF)
endif

ifeq ($(BR2_PACKAGE_MUPEN64PLUS_VIDEO_GLIDE64MK2),y)
define CONFIGURE_N64_MUPEN64PLUS_GLIDE64MK2_DEF
	echo -e '\t\t\t\t<core>glide64mk2</core>' >> $(SYSTEM_XML_N64)

endef
RECALBOX_ROMFS_N64_CONFIGURE_CMDS += $(CONFIGURE_N64_MUPEN64PLUS_GLIDE64MK2_DEF)
endif

ifeq ($(BR2_PACKAGE_MUPEN64PLUS_GLES2),y)
define CONFIGURE_N64_MUPEN64PLUS_N64_DEF
	echo -e '\t\t\t\t<core>n64</core>' >> $(SYSTEM_XML_N64)

endef
RECALBOX_ROMFS_N64_CONFIGURE_CMDS += $(CONFIGURE_N64_MUPEN64PLUS_N64_DEF)
endif

ifeq ($(BR2_PACKAGE_MUPEN64PLUS_GLIDEN64),y)
define CONFIGURE_N64_MUPEN64PLUS_GLIDEN64_DEF
	echo -e '\t\t\t\t<core>gliden64</core>' >> $(SYSTEM_XML_N64)

endef
RECALBOX_ROMFS_N64_CONFIGURE_CMDS += $(CONFIGURE_N64_MUPEN64PLUS_GLIDEN64_DEF)
endif

define CONFIGURE_N64_MUPEN64PLUS_END
	echo -e '\t\t\t</cores>' >> $(SYSTEM_XML_N64)

	echo -e '\t\t</emulator>' >> $(SYSTEM_XML_N64)

endef
RECALBOX_ROMFS_N64_CONFIGURE_CMDS += $(CONFIGURE_N64_MUPEN64PLUS_END)
endif



define CONFIGURE_MAIN_N64_END
	echo -e '\t</emulators>\n' \
	'</system>' >> $(SYSTEM_XML_N64)
	cp -R $(SOURCE_ROMDIR_N64) $(@D)
endef
RECALBOX_ROMFS_N64_CONFIGURE_CMDS += $(CONFIGURE_MAIN_N64_END)
endif

$(eval $(generic-package))
