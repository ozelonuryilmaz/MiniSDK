import Foundation

public final class MiniSDK {
    
    // MARK: Singleton Access
    
    public static var shared: MiniSDK {
        guard let instance = privateInstance else {
            assertionFailure("MiniSDK.initialize(apiKey:) çağrılmadan önce shared erişildi.")
            return MiniSDK(
                configuration: Configuration(apiKey: "undefined"),
                logger: SDKLogger(level: .error),
                tokenStore: TokenStore(base64Enabled: true),
                lifecycleObserver: StubLifecycleObserver()
            )
        }
        return instance
    }
    
    private static let syncQueue = DispatchQueue(label: "com.minisdk.singleton", attributes: .concurrent)
    nonisolated(unsafe) private static var _privateInstance: MiniSDK? = nil
    private static var privateInstance: MiniSDK? {
        get { syncQueue.sync { _privateInstance } }
        set { let value = newValue
            syncQueue.async(flags: .barrier) { _privateInstance = value }
        }
    }
    
    // MARK: API Methods
    
    public static func initialize(apiKey: String) {
        let logger = SDKLogger(level: .info)
        let tokenStore = TokenStore(base64Enabled: true)
        let lifecycleObserver = AppLifecycleObserver()
        let config = Configuration(apiKey: apiKey, environment: .production)
        
        let instance = MiniSDK(
            configuration: config,
            logger: logger,
            tokenStore: tokenStore,
            lifecycleObserver: lifecycleObserver
        )
        
        if let previous = privateInstance {
            previous.logger.log("SDK was already initialized. Reinitializing...", level: .warning)
        }
        
        logger.log("Initialized with API Key: \(apiKey)", level: .info)
        
        privateInstance = instance
        lifecycleObserver.startObserving(delegate: instance)
        instance.trackEvent(name: "sdk_initialized")
    }
    
    public func sendPushToken(token: String) {
        tokenStore.saveToken(token)
        let logMessage = "Push Token Sent: \(tokenStore.base64Enabled ? " (Base64 encoded)" : "")"
        logger.log(logMessage, level: .info)
        trackEvent(name: "push_token_saved", payload: ["length": token.count])
    }
    
    public func trackEvent(name: String, payload: [String: Any]? = nil) {
        var log = "Event: \(name)"
        if let payload = payload,
           let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: .sortedKeys),
           let json = String(data: jsonData, encoding: .utf8) {
            log += ", Payload: \(json)"
        }
        logger.log(log, level: .info)
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
}
