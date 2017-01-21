################################################################################
#
# recalbox-romfs
#
################################################################################

RECALBOX_ROMFS_SOURCE =
RECALBOX_ROMFS_SITE =
RECALBOX_ROMFS_INSTALL_STAGING = NO

ES_SYSTEMS = $(@D)/es_systems.cfg
TARGET_ES_SYSTEMS_DIR = $(TARGET_DIR)/recalbox/share_init/system/.emulationstation
TARGET_ROMDIR = $(TARGET_DIR)/recalbox/share_init/

CONFIGGEN_STD_CMD = python /usr/lib/python2.7/site-packages/configgen/emulatorlauncher.pyc %CONTROLLERSCONFIG% -system %SYSTEM% -rom %ROM% -emulator %EMULATOR% -core %CORE% -ratio %RATIO%

# Each emulator must define :
#  - its es_systems.cfg entry
#  - its source roms folder
# You MUST add an empty line at the end of the define otherwise some commands
# will overlap and fail

# Init the es_systems.cfg
# Keep the empty line as there are several commands to chain at configure
define RECALBOX_ROMFS_ES_SYSTEMS
	echo '<?xml version="1.0"?>' > $(ES_SYSTEMS)
	echo '<systemList>' >>  $(ES_SYSTEMS)
	cat $(@D)/../recalbox-romfs-*/*.xml >> $(ES_SYSTEMS)
	echo -e '<system>\n' \
		"\t<fullname>Favorites</fullname>\n" \
		'\t<name>favorites</name>\n' \
		"\t<command>$(CONFIGGEN_STD_CMD)</command>\n" \
		"\t<theme>favorites</theme>\n" \
	"</system>\n" \
	'</systemList>' >>  $(ES_SYSTEMS)
	
endef
RECALBOX_ROMFS_CONFIGURE_CMDS += $(RECALBOX_ROMFS_ES_SYSTEMS)

# Copy rom dirs
define RECALBOX_ROMFS_ROM_DIRS
	cp -R $(@D)/../recalbox-romfs-*/roms $(@D)
	
endef
RECALBOX_ROMFS_CONFIGURE_CMDS += $(RECALBOX_ROMFS_ROM_DIRS)

# Copy from build to target
define RECALBOX_ROMFS_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_ROMDIR)/roms
	mkdir -p $(TARGET_ES_SYSTEMS_DIR)
	$(INSTALL) -D -m 0644 $(ES_SYSTEMS) $(TARGET_ES_SYSTEMS_DIR)
	cp -r $(@D)/roms $(TARGET_ROMDIR)
endef

# Add necessary dependencies
# System: amstradcpc
ifneq ($(BR2_PACKAGE_LIBRETRO_CAP32),)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-amstradcpc
endif

# System: apple2
ifeq ($(BR2_PACKAGE_LINAPPLE_PIE),y)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-apple2
endif

# System: atari2600
ifneq ($(BR2_PACKAGE_LIBRETRO_STELLA),)
    RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-atari2600
endif

# System: atari7800
ifneq ($(BR2_PACKAGE_LIBRETRO_PROSYSTEM),)
    RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-atari7800
endif

# System: atarist
ifneq ($(BR2_PACKAGE_LIBRETRO_HATARI),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-atarist
endif

# System: c64
ifneq ($(BR2_PACKAGE_VICE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-c64
endif

# System: cavestory
ifneq ($(BR2_PACKAGE_LIBRETRO_NXENGINE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-cavestory
endif

# System: colecovision
ifneq ($(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-colecovision
endif

# System: dos
ifeq ($(BR2_PACKAGE_DOSBOX),y)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-dos
endif

# Sytem: dreamcast
ifeq ($(BR2_PACKAGE_REICAST),y)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-dreamcast
endif

# System: fba
ifneq ($(BR2_PACKAGE_LIBRETRO_FBA)$(BR2_PACKAGE_PIFBA),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-fba
endif

# System: fba_libretro
ifneq ($(BR2_PACKAGE_LIBRETRO_FBA),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-fba_libretro
endif

# System: fds
ifneq ($(BR2_PACKAGE_LIBRETRO_FCEUMM)$(BR2_PACKAGE_LIBRETRO_NESTOPIA),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-fds
endif

# System: gamecube
ifeq ($(BR2_PACKAGE_DOLPHIN_EMU),y)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-gamecube
endif

# System: gamegear
ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-gamegear
endif

# System: gb
ifneq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE)$(BR2_PACKAGE_LIBRETRO_TGBDUAL),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-gb
endif

# System: gba
ifneq ($(BR2_PACKAGE_LIBRETRO_GPSP)$(BR2_PACKAGE_LIBRETRO_MGBA)$(BR2_PACKAGE_LIBRETRO_METEOR),)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-gba
endif

# System: gbc
ifneq ($(BR2_PACKAGE_LIBRETRO_GAMBATTE)$(BR2_PACKAGE_LIBRETRO_TGBDUAL),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-gbc
endif

# System: gw
ifneq ($(BR2_PACKAGE_LIBRETRO_GW),)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-gw
endif

# System: lutro
ifneq ($(BR2_PACKAGE_LIBRETRO_LUTRO),)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-lutro
endif

# System: lynx
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_LYNX),)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-lynx
endif

# System: mame
ifneq ($(BR2_PACKAGE_LIBRETRO_MAME2003)$(BR2_PACKAGE_LIBRETRO_IMAME)$(BR2_PACKAGE_ADVANCEMAME),)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-mame
endif

# System: mastersystem
ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-mastersystem
endif

# System: megadrive
ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-megadrive
endif

# System: moonlight
ifeq ($(BR2_PACKAGE_MOONLIGHT_EMBEDDED),y)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-moonlight
endif

# System: msx
ifneq ($(BR2_PACKAGE_LIBRETRO_FMSX)$(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-msx
endif

# System: msx1
ifneq ($(BR2_PACKAGE_LIBRETRO_FMSX)$(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-msx1
endif

# System: msx2
ifneq ($(BR2_PACKAGE_LIBRETRO_FMSX)$(BR2_PACKAGE_LIBRETRO_BLUEMSX),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-msx2
endif

# System: neogeo
ifneq ($(BR2_PACKAGE_LIBRETRO_MAME2003)$(BR2_PACKAGE_LIBRETRO_FBA)$(BR2_PACKAGE_LIBRETRO_IMAME)$(BR2_PACKAGE_PIFBA),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-neogeo
endif

# System: nes
ifneq ($(BR2_PACKAGE_LIBRETRO_FCEUMM)$(BR2_PACKAGE_LIBRETRO_FCEUNEXT)$(BR2_PACKAGE_LIBRETRO_NESTOPIA)$(BR2_PACKAGE_LIBRETRO_QUICKNES),)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-nes
endif

# System: ngp
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-ngp
endif

# System: ngpc
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_NGP),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-ngpc
endif

# System: o2em
ifneq ($(BR2_PACKAGE_LIBRETRO_O2EM),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-o2em
endif

# System: pcengine
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-pcengine
endif

# System: pcenginecd
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-pcenginecd
endif

# System: supergrafx
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_SUPERGRAFX)$(BR2_PACKAGE_LIBRETRO_BEETLE_PCE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-supergrafx
endif

# System: psp
ifeq ($(BR2_PACKAGE_PPSSPP),y)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-psp
endif

# System: psx
ifneq ($(BR2_PACKAGE_LIBRETRO_PCSX),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-psx
endif

# System: prboom
ifneq ($(BR2_PACKAGE_LIBRETRO_PRBOOM),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-prboom
endif

# System: scummvm
ifeq ($(BR2_PACKAGE_SCUMMVM),y)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-scummvm
endif

# System: sega32x
ifneq ($(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-sega32x
endif

# System: segacd
ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-segacd
endif

# System: sg1000
ifneq ($(BR2_PACKAGE_LIBRETRO_GENESISPLUSGX)$(BR2_PACKAGE_LIBRETRO_PICODRIVE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-sg1000
endif

# System: snes
ifneq ($(BR2_PACKAGE_LIBRETRO_SNES9X_NEXT)$(BR2_PACKAGE_LIBRETRO_CATSFC)$(BR2_PACKAGE_LIBRETRO_POCKETSNES),)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-snes
endif

# System: vectrex
ifneq ($(BR2_PACKAGE_LIBRETRO_VECX),)
	RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-vectrex
endif

# System: virtualboy
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_VB),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-virtualboy
endif

# System: wii
ifeq ($(BR2_PACKAGE_DOLPHIN_EMU),y)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-wii
endif

# System: wswan
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-wswan
endif

# System: wswanc
ifneq ($(BR2_PACKAGE_LIBRETRO_BEETLE_WSWAN),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-wswanc
endif

# System: zx81
ifneq ($(BR2_PACKAGE_LIBRETRO_81),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-zx81
endif

# System: zxspectrum
ifneq ($(BR2_PACKAGE_LIBRETRO_FUSE),)
        RECALBOX_ROMFS_DEPENDENCIES += recalbox-romfs-zxspectrum
endif


$(eval $(generic-package))
