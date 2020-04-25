include $(THEOS)/makefiles/common.mk

export TARGET = iphone:clang:12.1.2:12.0
export ARCHS = arm64 arm64e

TWEAK_NAME = EZSwipe
EZSwipe_FILES = EZSwipe.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += Prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
