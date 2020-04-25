include $(THEOS)/makefiles/common.mk

export TARGET = iphone:clang:12.1.2:12.0

export ARCHS = arm64 arm64e

BUNDLE_NAME = EZSwipe
EZSwipe_FILES = EZRootListController.m
EZSwipe_INSTALL_PATH = /Library/PreferenceBundles
EZSwipe_FRAMEWORKS = UIKit
EZSwipe_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/EZSwipe.plist$(ECHO_END)
