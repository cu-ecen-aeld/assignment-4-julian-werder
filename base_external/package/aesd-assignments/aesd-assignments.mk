##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

# SITE must use the ssh (git@github.com:) form: the course autotest
# (assignment-autotest/test/shared/buildroot-common-build.sh) records a
# validation error and rewrites the file if this line starts with https.
# VERSION is the published assignment-4-part-1 commit.
AESD_ASSIGNMENTS_VERSION = 27ff3c5d0e9287ba77cabf5aebb9255d5cc0785f
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignment-3-julian-werder.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/finder-app/conf
	for f in $(@D)/conf/*; do \
		[ -e "$$f" ] || continue; \
		$(INSTALL) -D -m 0755 "$$f" $(TARGET_DIR)/etc/finder-app/conf/$$(basename "$$f") || exit 1; \
	done
	$(INSTALL) -D -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/writer
	$(INSTALL) -D -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/finder.sh
	for f in $(@D)/assignment-autotest/test/assignment4/*.sh; do \
		[ -e "$$f" ] || continue; \
		$(INSTALL) -D -m 0755 "$$f" $(TARGET_DIR)/usr/bin/$$(basename "$$f") || exit 1; \
	done
	$(INSTALL) -D -m 0755 $(AESD_ASSIGNMENTS_PKGDIR)/finder-test.sh $(TARGET_DIR)/usr/bin/finder-test.sh
	$(INSTALL) -D -m 0755 $(AESD_ASSIGNMENTS_PKGDIR)/finder.sh $(TARGET_DIR)/usr/bin/finder.sh
endef

$(eval $(generic-package))
