################################################################################
#
# lirc-tools
#
################################################################################

#LIRC_TOOLS_VERSION = 0.9.4pre1
LIRC_TOOLS_VERSION = 0.9.3a
LIRC_TOOLS_SOURCE = lirc-$(LIRC_TOOLS_VERSION).tar.bz2
LIRC_TOOLS_SITE = http://downloads.sourceforge.net/project/lirc/LIRC/$(LIRC_TOOLS_VERSION)
LIRC_TOOLS_LICENSE = GPLv2+
LIRC_TOOLS_LICENSE_FILES = COPYING
LIRC_TOOLS_DEPENDENCIES = host-libxslt host-pkgconf host-python3 linux-headers
LIRC_TOOLS_INSTALL_STAGING = YES

#LIRC_TOOLS_MAKE=$(MAKE1)

LIRC_TOOLS_CONF_ENV = XSLTPROC=yes 
#LIRC_TOOLS_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -std=gnu99"
#LIRC_TOOLS_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -I$(LINUX_HEADERS_DIR)/include"
#LIRC_TOOLS_CONF_ENV += LDFLAGS="$(TARGET_LDFLAGS) -L$(LIRC_TOOLS_DIR)/lib/.libs" 
LIRC_TOOLS_CONF_OPTS = --without-x
LIRC_TOOLS_MAKE=$(MAKE1)
define LIRC_TOOLS_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/lirc-tools/S25lircd \
		$(TARGET_DIR)/etc/init.d/S25lircd
endef

$(eval $(autotools-package))
