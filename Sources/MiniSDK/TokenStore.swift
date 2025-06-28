public protocol TokenStoreProtocol {
    func saveToken(_ token: String)
    func retrieveToken() -> String?
}

public struct TokenStore: TokenStoreProtocol {
    private let base64Enabled: Bool
    
    public init(base64Enabled: Bool) {
        self.base64Enabled = base64Enabled
    }
    
    public func saveToken(_ token: String) {
        
    }
    
    public func retrieveToken() -> String? {
        
    }
}
