# Hedef Cihaz ve Mimari
TARGET := iphone:clang:latest:14.0
ARCHS = arm64

# Hilenin çalışacağı oyun (Critical Ops Bundle ID'si genelde budur, değişebilir)
INSTALL_TARGET_PROCESSES = com.criticalforceentertainment.criticalops

include $(THEOS)/makefiles/common.mk

# Tweak Adı (Sen ne istersen o olur ama aşağıyla tutmalı)
TWEAK_NAME = CriticalOpsESP

# Derlenecek Dosyalar (Senin kodun Tweak.xm içinde olmalı!)
CriticalOpsESP_FILES = Tweak.xm

# GEREKLİ KÜTÜPHANELER (ESP Çizimi için ŞART)
CriticalOpsESP_FRAMEWORKS = UIKit Foundation Security QuartzCore CoreGraphics

# Derleme Ayarları (C++17 ve hata gizleme)
CriticalOpsESP_CCFLAGS = -std=c++17 -fno-rtti -fno-exceptions -DNDEBUG

include $(THEOS_MAKE_PATH)/tweak.mk
