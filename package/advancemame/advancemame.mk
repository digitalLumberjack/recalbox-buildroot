################################################################################
#
# ADVANCEMAME
#
################################################################################
ADVANCEMAME_VERSION = fdd33b5f5d803aaae3109b5d18a6a90012f490cd
ADVANCEMAME_SITE = $(call github,amadvance,advancemame,$(ADVANCEMAME_VERSION))

ADVANCEMAME_DEPENDENCIES = sdl zlib 

ADVANCEMAME_LDFLAGS = -L$(STAGING_DIR)/usr/lib
ADVANCEMAME_CFLAGS = -I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/usr/include/SDL

ifeq ($(BR2_cortex_a7),y)
        #ADVANCEMAME_CONF_OPTS = -DRPI_VERSION=2
	ADVANCEMAME_CFLAGS+= -mcpu=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard
else ifeq ($(BR2_cortex_a8),y)
        #ADVANCEMAME_CONF_OPTS = -DRPI_VERSION=3
	ADVANCEMAME_CFLAGS+= -mcpu=cortex-a8 -mfpu=neon-vfpv4 -mfloat-abi=hard
else
        #ADVANCEMAME_CONF_OPTS = -DRPI_VERSION=1
	ADVANCEMAME_CFLAGS+= -mfpu=vfp -march=armv6j -mfloat-abi=hard
endif

define ADVANCEMAME_CONFIGURE_CMDS
        (cd $(@D); ./autogen.sh; \
        $(TARGET_CONFIGURE_ARGS) \
                $(TARGET_CONFIGURE_OPTS) \
                CFLAGS="$(TARGET_CFLAGS) $(ADVANCEMAME_CFLAGS)" \
                CXXFLAGS="$(TARGET_CXXFLAGS) $(ADVANCEMAME_CFLAGS)" \
                CPPFLAGS="$(TARGET_CPPFLAGS) $(ADVANCEMAME_CFLAGS)" \
                LDFLAGS="$(TARGET_LDFLAGS) $(ADVANCEMAME_LDFLAGS)" \
                CROSS_COMPILE="$(HOST_DIR)/usr/bin/" \
                ./configure --host=arm-buildroot-linux-gnueabihf \
                --with-sdl-prefix="$(STAGING_DIR)/usr"; \
        )
endef


$(eval $(autotools-package))

