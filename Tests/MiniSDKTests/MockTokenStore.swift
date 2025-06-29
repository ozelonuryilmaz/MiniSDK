@testable import MiniSDK

final class MockTokenStore: TokenStoreProtocol {
    var base64Enabled: Bool = false
    var savedToken: String?
    
    func saveToken(_ token: String) {
        savedToken = token
    }
    
    func retrieveToken() -> String? {
        return savedToken
    }
}
