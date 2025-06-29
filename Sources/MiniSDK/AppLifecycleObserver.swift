import UIKit

public protocol LifecycleObserverProtocol {
    func startObserving(delegate: MiniSDK)
}

public final class AppLifecycleObserver: LifecycleObserverProtocol {
    private weak var delegate: MiniSDK?
    
    public init() {}
    
    public func startObserving(delegate: MiniSDK) {
        self.delegate = delegate
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
    }
    
    @objc private func appDidBecomeActive() {
        delegate?.trackEvent(name: "app_foregrounded")
    }
    
    @objc private func appDidEnterBackground() {
        delegate?.trackEvent(name: "app_backgrounded")
    }
}
