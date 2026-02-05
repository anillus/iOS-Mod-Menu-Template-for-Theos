TARGET := iphone:clang:latest:26.0.1
INSTALL_TARGET_PROCESSES = CriticalOps

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CriticalCheats

# Buraya kod dosyamızın adını yazıyoruz
CriticalCheats_FILES = Tweak.xm
CriticalCheats_CFLAGS = -fobjc-arc

# Unity oyunları için gerekli frameworkler
CriticalCheats_FRAMEWORKS = UIKit Foundation Security

include $(THEOS_MAKE_PATH)/tweak.mk
