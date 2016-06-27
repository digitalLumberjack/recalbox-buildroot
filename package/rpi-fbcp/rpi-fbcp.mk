################################################################################
#
#rpi-fbcp
#
################################################################################

RPI_FBCP_VERSION = 8087a71d0330a078d91aa78656684ab5313616c6
RPI_FBCP_SITE = $(call github,tasanakorn,rpi-fbcp,$(RPI_FBCP_VERSION))
RPI_FBCP_DEPENDENCIES += rpi-userland

define RPI_FBCP_CROSS_FIXUP
        $(SED) 's|/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/CMakeLists.txt 
        $(SED) 's|/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/CMakeLists.txt 
        $(SED) 's|bcm_host|bcm_host vchostif|g' $(@D)/CMakeLists.txt 
endef

RPI_FBCP_PRE_CONFIGURE_HOOKS += RPI_FBCP_CROSS_FIXUP

define RPI_FBCP_INSTALL_TARGET_CMDS 
	$(INSTALL) -m 0755 -D $(@D)/fbcp $(TARGET_DIR)/usr/bin 
endef 

$(eval $(cmake-package))
