# CHALLENGES.md – MiniSDK

## 🎯 Teknik Tercihler ve Mimari Kararlar

### 1. Singleton SDK Tasarımı
- `MiniSDK.shared` ile global, thread-safe singleton erişimi sağlandı.
- Concurrency uyumu için `DispatchQueue` ile senkronizasyon yapıldı.

### 2. Value Type Kullanımı
- `Configuration`, `TokenStore`, `SDKLogger` gibi yapıların çoğu `struct`.
- Bu tercih, hafiflik, test edilebilirlik ve performans artışı sağlar.

### 3. Loglama Sistemi
- `SDKLoggerProtocol` ve `LogLevel` enum ile seviyeyle filtrelenebilir log yapısı sağlandı.
- `[MiniSDK] Event: ...` formatında kullanıcı dostu loglar atılır.

### 4. Lifecycle Observer
- `AppLifecycleObserver` otomatik olarak foreground/background event’lerini takip eder.
- `StubLifecycleObserver` test amaçlı boş gözlemci olarak kullanılır.

### 5. Güvenli Token Saklama
- `TokenStoreProtocol` abstraction’ı ile `KeychainHelper` kullanılarak güvenli token saklama yapılır.
- Opsiyonel olarak `Base64` encode edilerek loglama desteği verilir.

### 6. Genişletilebilir Başlatma Yapısı
- `MiniSDK.initialize(apiKey:)` ile API key üzerinden başlatılır.
- Daha önce başlatılmışsa yeniden başlatıldığı loglanır.

### 7. Event Takibi
- `trackEvent(name:payload:)` SDK’nın merkez loglama fonksiyonudur.
- Payload’lar JSON formatında detaylı olarak loglara dahil edilir.

### 8. Test Edilebilirlik
- SDK bileşenleri `protocol` üzerinden sağlandığı için kolayca mock edilebilir.
- Unit testlerde `GIVEN-WHEN-THEN` yaklaşımı uygulanır.

### 9. Foundation ve UIKit Ayrımı
- UIKit sadece lifecycle gözlemlemek için kullanıldı.
- Swift Package olarak kullanımda minimum bağımlılık hedeflendi.
