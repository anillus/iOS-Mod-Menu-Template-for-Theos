#import <UIKit/UIKit.h>
#import <substrate.h>
#import <mach-o/dyld.h>

// --- SENİN VERDİĞİN OFFSETLER ---
uint64_t O_WorldToViewportPoint = 0x1638dd4;
uint64_t O_get_main = 0x163a384;
uint64_t O_get_transform = 0x167f570;
uint64_t O_get_position = 0x1694170;
uint64_t O_getTeamIndex = 0x36adc0;
uint64_t O_PlayerAdapter_ctor = 0x36b0e4;
uint64_t O_get_LocalCharacter = 0x51e46c;
uint64_t O_GetUsername = 0x77e684;

// --- YARDIMCI FONKSİYONLAR ---

// UnityFramework veya ana oyunun başlangıç adresini bulur
uintptr_t get_base_address() {
    return _dyld_get_image_vmaddr_slide(0);
}

// Senin "getBase" dediğin mantık
uintptr_t getBase(const char* framework) {
    // Basitlik olsun diye ana slide'ı döndürüyoruz
    // UnityFramework genelde image 0 olur bu tip buildlerde
    return _dyld_get_image_vmaddr_slide(0);
}

// --- TWEAK BAŞLANGICI ---
%ctor {
    NSLog(@"[CriticalCheats] Tweak injected ve calisiyor!");

    // Senin verdigin pointer mantigi (C++ -> Objective-C/Theos uyumlu hali)
    // Bu kod oyun acildigi an bir kere calisir.
    
    uintptr_t unityBase = get_base_address();
    
    // NOT: Bu adresler dinamik oldugu icin oyun acikken pointerlar bos olabilir.
    // Crash vermemesi icin korumaya aldim.
    
    uintptr_t typinfoAddr = unityBase + 0x46ed358;
    
    NSLog(@"[CriticalCheats] Base Address: 0x%lx", unityBase);
    NSLog(@"[CriticalCheats] TypInfo Address: 0x%lx", typinfoAddr);
    
    // Diger pointer zincirlerini (chain) burada tanimlayabilirsin
    // Ancak oyunun "Update" fonksiyonuna hook atmadan surekli veri cekemezsin.
    // Su an bu kod sadece oyuna enjekte oldugunu kanitlar.
}
