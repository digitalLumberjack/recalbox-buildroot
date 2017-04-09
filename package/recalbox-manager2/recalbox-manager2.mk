################################################################################
#
# RECALBOX_MANAGER2
#
################################################################################
RECALBOX_MANAGER2_VERSION = v1.0-beta6
RECALBOX_MANAGER2_SITE = $(call github,djlechuck,recalboxmanager,$(RECALBOX_MANAGER2_VERSION))
RECALBOX_MANAGER2_SITE = git://github.com/DjLeChuck/recalbox-manager
RECALBOX_MANAGER2_DEPENDENCIES = nodejs

NPM = $(TARGET_CONFIGURE_OPTS) \
	LD="$(TARGET_CXX)" \
	npm_config_arch=arm \
	npm_config_target_arch=arm \
	npm_config_build_from_source=true \
	npm_config_nodedir=$(BUILD_DIR)/nodejs-$(NODEJS_VERSION) \
	$(HOST_DIR)/usr/bin/npm


define RECALBOX_MANAGER2_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/recalbox-manager2
	cp -r $(@D)/* \
		$(TARGET_DIR)/usr/recalbox-manager2

	mv $(TARGET_DIR)/usr/recalbox-manager2/app.js $(TARGET_DIR)/usr/recalbox-manager2/recalbox-manager2.js

	cd $(TARGET_DIR)/usr/recalbox-manager2 && mkdir -p node_modules && \
		$(NPM) install \

endef


$(eval $(generic-package))
