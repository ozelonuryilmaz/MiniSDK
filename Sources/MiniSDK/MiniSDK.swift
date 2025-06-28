import Foundation
import UIKit

public final class MiniSDK {
    
    // MARK: Singleton Access
    
    public static var shared: MiniSDK {
        guard let instance = internalShared else {
            assertionFailure("MiniSDK.initialize(apiKey:) çağrılmadan önce shared erişildi.")
            return MiniSDK.uninitializedStub
        }
        return instance
    }
    
    private static var internalShared: MiniSDK?
    
    // MARK: API Methods
    
    public static func initialize(apiKey: String, base64EncodePushToken: Bool = false) {
        
    }
    
    public func sendPushToken(token: String) {
        
    }
    
    public func trackEvent(name: String, payload: [String: Any]? = nil) {
        
    }
    
    // MARK: Dependencies Injection
    
    internal let configuration: Configuration
    internal let logger: SDKLoggerProtocol
    internal let tokenStore: TokenStoreProtocol
    internal let lifecycleObserver: LifecycleObserverProtocol
    
    internal init(configuration: Configuration,
                logger: SDKLoggerProtocol,
                tokenStore: TokenStoreProtocol,
                lifecycleObserver: LifecycleObserverProtocol) {
        self.configuration = configuration
        self.logger = logger
        self.tokenStore = tokenStore
        self.lifecycleObserver = lifecycleObserver
    }
    
    // MARK: Fallback
    
    private static let uninitializedStub = MiniSDK(
        configuration: Configuration(apiKey: "undefined"),
        logger: SDKLogger(level: .error),
        tokenStore: TokenStore(base64Enabled: false),
        lifecycleObserver: StubLifecycleObserver()
    )
}
