#import "Macros.h"
#import <mach-o/dyld.h>
#import <vector>

// --- SENİN VERDİĞİN OFFSELER ---
#define OFF_TYPINFO 0x46ed358  // typinfoAddr
#define OFF_SYSTEM  0x30       // gameSystem offset
#define OFF_LIST    0xD0       // characters list offset
#define OFF_HEALTH  0x108      // Health offset
#define OFF_POS     0x1694170  // Transform position

// UnityFramework Base Adresini Bulma (getBase mantığı)
uintptr_t get_UnityFramework() {
    return (uintptr_t)_dyld_get_image_header(0);
}

// --- MENÜ KURULUMU ---
void setupMenu() {
    [menu setFrameworkName:"Anıl C-OPS v1"];

    [switches addSwitch:NSSENCRYPT("ESP Aktif")
        description:NSSENCRYPT("Düşmanları Gösterir")
    ];
    
    [switches addSwitch:NSSENCRYPT("Can Göster")
        description:NSSENCRYPT("Adamların canını gör")
    ];
}

// --- SENİN KOD MANTIĞIN ---
void RunLogic() {
    // Menüden ESP kapalıysa boşuna işlemciyi yorma
    if(![switches isSwitchOn:NSSENCRYPT("ESP Aktif")]) return;

    uintptr_t base = get_UnityFramework();
    
    // 1. ADIM: typinfoAddr
    uintptr_t typInfoAddr = base + OFF_TYPINFO;
    
    // 2. ADIM: gameModuleInstance (Pointer okuma)
    // Adres geçerli mi diye kontrol ediyoruz (Crash yememek için)
    if(typInfoAddr == 0) return;
    void* gameModuleInstance = *(void**)(typInfoAddr);
    if(gameModuleInstance == NULL) return;
    
    // 3. ADIM: gameSystem (+0x30)
    void* gameSystem = *(void**)((uint64_t)gameModuleInstance + OFF_SYSTEM);
    if(gameSystem == NULL) return;
    
    // 4. ADIM: characters Listesi (+0xD0)
    void* charactersList = *(void**)((uint64_t)gameSystem + OFF_LIST);
    if(charactersList == NULL) return;
    
    // Liste boyutunu al (C# List yapısı: 0x18 size, 0x20 items)
    int count = *(int*)((uint64_t)charactersList + 0x18);
    uintptr_t items = (uintptr_t)charactersList + 0x20; 

    // 5. ADIM: Döngü (Her adamı tek tek kontrol et)
    for (int i = 0; i < count; i++) {
        // Listeden karakteri çek
        void* character = *(void**)(items + (i * 0x8));
        if (!character) continue;
        
        // 6. ADIM: Can Değeri (+0x108)
        int health = *(int*)((uint64_t)character + OFF_HEALTH);
        
        // Eğer canı 0'dan büyükse (Yaşıyorsa) işlem yap
        if (health > 0 && health <= 100) {
            // Burada ESP Çizimi yapılır.
            // (Şimdilik mantık çalışıyor mu diye arka planda okuyoruz)
        }
    }
}

// --- HOOK (Oyunun Update fonksiyonuna kanca atıyoruz) ---
%hook PlayerAdapter

- (void)Update {
    %orig;      // Oyunun orijinali çalışsın
    RunLogic(); // Bizim hile çalışsın
}

%end

%ctor {
    setupMenu();
}
