# MiniSDK

> **Hafif, Genişletilebilir, Test edilebilir**  
> MiniSDK, event loglama, push token gönderimi ve uygulama yaşam döngüsü takibi için geliştirilmiş Swift SDK'sıdır.

---

## ✨ Özellikler

- Singleton tabanlı başlatma (`initialize`)
- Uygulama yaşam döngüsü takibi (`app_foregrounded`, `app_backgrounded`)
- Push token'ı opsiyonel olarak Base64 formatında şifreleyerek loglama
- Seviyeli log sistemi (info, warning, error)
- Protokol bazlı bağımlılık enjeksiyonu ile test edilebilir yapı
- Hafif, Swift Package Manager (SPM) ile uyumlu
- iOS 13 ve üzeri destek

---

## 📦 Kurulum (Swift Package Manager ile)

### Xcode Üzerinden

> `File > Add Packages...` menüsünden aşağıdaki repo adresini girin:

```
https://github.com/ozelonuryilmaz/MiniSDK.git
```

> Sürüm olarak `1.0.0` veya üzerini seçip işlemi tamamlayın.

### Veya Package.swift içerisine ekleyin:

```swift
.package(url: "https://github.com/ozelonuryilmaz/MiniSDK.git", from: "1.0.0")
```

Hedefinize şu şekilde dahil edin:

```swift
.target(
  name: "Uygulamanız",
  dependencies: ["MiniSDK"]
)
```

---

## 🚀 Kullanım

### SDK Başlatma

```
import MiniSDK

MiniSDK.initialize(apiKey: "api-anahtarınız")
```

### Push Token Gönderimi

```
MiniSDK.shared.sendPushToken(token: "abc123")
```

> Örnek log çıktısı:
> `[MiniSDK][INFO] Push Token Sent: YWJjMTIz (Base64 encoded)`

### Event Loglama

```
MiniSDK.shared.trackEvent(name: "butona_tıklandı", payload: ["ekran": "AnaSayfa"])
```

---

## Test Edilebilirlik

MiniSDK, `Logger`, `TokenStore` ve `LifecycleObserver` gibi bileşenleri dışarıdan enjekte edilebilir şekilde tasarlanmıştır. Bu sayede kolayca mock'lanabilir ve unit test'e uygundur.

Örnek test:

```swift
let logger = MockLogger()
let sdk = MiniSDK(configuration: ..., logger: logger, ...)
sdk.trackEvent(name: "test_event")
XCTAssertEqual(logger.logs.count, 1)
```

---

## Mimari

- Singleton tabanlı başlatma
- `DispatchQueue` ile thread-safe yapı
- Bağımlılıklar `Protocol` üzerinden geçilir
- GIVEN - WHEN - THEN formatında test yazımı
- UIKit bağımsız, UI thread’ini asla engellemez

---
