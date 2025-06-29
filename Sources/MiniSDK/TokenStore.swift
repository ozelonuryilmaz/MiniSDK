import Foundation

public protocol TokenStoreProtocol {
    var isBase64Enabled: Bool { get }
    func saveToken(_ token: String) -> String
    func retrieveToken() -> String?
}

public struct TokenStore: TokenStoreProtocol {
    private let key = "com.minisdk.push_token"
    public let isBase64Enabled: Bool
    
    public init(base64Enabled: Bool) {
        self.isBase64Enabled = base64Enabled
    }
    
    @discardableResult
    public func saveToken(_ token: String) -> String {
        let encoded = isBase64Enabled ? Data(token.utf8).base64EncodedString() : token
        if let data = encoded.data(using: .utf8) {
            KeychainHelper.save(key: key, data: data)
        }
        return encoded
    }
    
    public func retrieveToken() -> String? {
        guard let data = KeychainHelper.load(key: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
