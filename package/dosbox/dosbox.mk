################################################################################
#
# DosBox
#
################################################################################

DOSBOX_SITE =  svn://svn.code.sf.net/p/dosbox/code-0/dosbox/trunk 
DOSBOX_SITE_METHOD = svn
DOSBOX_VERSION = r3970
DOSBOX_LICENSE = GPL2
DOSBOX_LICENSE_FILES = COPYING
DOSBOX_DEPENDENCIES = sdl zlib libpng libogg libvorbis sdl_sound sdl_net

DOSBOX_LDFLAGS = -L$(STAGING_DIR)/usr/lib
DOSBOX_CFLAGS = -I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/usr/include/SDL

define DOSBOX_CONFIGURE_CMDS
        (cd $(@D); ./autogen.sh; \
        $(TARGET_CONFIGURE_ARGS) \
                $(TARGET_CONFIGURE_OPTS) \
                CFLAGS="$(TARGET_CFLAGS) $(DOSBOX_CFLAGS)" \
                CXXFLAGS="$(TARGET_CXXFLAGS) $(DOSBOX_CFLAGS)" \
                CPPFLAGS="$(TARGET_CPPFLAGS) $(DOSBOX_CFLAGS)" \
                LDFLAGS="$(TARGET_LDFLAGS) $(DOSBOX_LDFLAGS)" \
                CROSS_COMPILE="$(HOST_DIR)/usr/bin/" \
                ./configure --host=arm-buildroot-linux-gnueabihf \
                --enable-core-inline --disable-opengl --prefix=/usr \
                --enable-dynrec --enable-unaligned_memory \
                --with-sdl-prefix="$(STAGING_DIR)/usr"; \
        sed -i "s/C_TARGETCPU.*/C_TARGETCPU ARMV7LE/g" config.h; \
        sed -i "s/SVN/$(DOSBOX_VERSION_TAG)/g" config.h; \
        echo "#define C_DYNREC 1" >>config.h; \
        echo "#define C_UNALIGNED_MEMORY 1" >>config.h \
        )
endef


$(eval $(autotools-package))
