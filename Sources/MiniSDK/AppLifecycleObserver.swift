public protocol LifecycleObserverProtocol {
    func startObserving(delegate: MiniSDK)
}

public class AppLifecycleObserver: LifecycleObserverProtocol {
    private weak var delegate: MiniSDK?
    
    public init() {}
    
    public func startObserving(delegate: MiniSDK) {
        self.delegate = delegate
        
    }
}
