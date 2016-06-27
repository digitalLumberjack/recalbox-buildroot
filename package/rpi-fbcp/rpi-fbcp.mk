################################################################################
#
#rpi-fbcp
#
################################################################################

RPI_FBCP_VERSION = c1d05f8d8e02641726691f95d9cd85a76a33af85
RPI_FBCP_SITE = $(call github,ian57,rpi-fbcp,$(RPI_FBCP_VERSION))
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
