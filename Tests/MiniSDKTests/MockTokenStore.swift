@testable import MiniSDK

final class MockTokenStore: TokenStoreProtocol {
    var isBase64Enabled: Bool = false
    var savedToken: String?
    
    func saveToken(_ token: String) -> String {
        savedToken = token
        return token
    }
    
    func retrieveToken() -> String? {
        return savedToken
    }
}
