################################################################################
#
# REICAST
#
################################################################################
LIBRETRO_REICAST_VERSION = ccc206c4e57eb7170339eae98fcbe0598308516f
LIBRETRO_REICAST_SITE = $(call github,libretro,reicast-emulator,$(LIBRETRO_REICAST_VERSION))
LIBRETRO_REICAST_DEPENDENCIES = rpi-userland


#ifeq ($(BR2_cortex_a7),y)
#        LIBRETRO_REICAST_PLATFORM=rpi2
#else
#        LIBRETRO_REICAST_PLATFORM=rpi
#endif

define LIBRETRO_REICAST_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_PLATFORM)"
endef


#define LIBRETRO_REICAST_BUILD_CMDS
	#CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_REICAST_PLATFORM)" WITH_DYNAREC=arm
	#CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS) -std=c++11" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/shell/rapi2/ -f Makefile platform="$(LIBRETRO_REICAST_PLATFORM)" 
#	$(MAKE)  CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" platform=rpi2 -C $(@D)/shell/linux/ -f Makefile
#endef


#define LIBRETRO_REICAST_BUILD_CMDS
	#mkdir -p $(@D)/obj/mame/cpu/ccpu
#	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_CC)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" -C $(@D)/ -f Makefile ARCH="$(TARGET_CFLAGS) -fsigned-char"
#endef

#define LIBRETRO_REICAST_INSTALL_TARGET_CMDS
#	$(INSTALL) -D $(@D)/mame078_libretro.so \
#		$(TARGET_DIR)/usr/lib/libretro/mame078_libretro.so
#endef

$(eval $(generic-package))
