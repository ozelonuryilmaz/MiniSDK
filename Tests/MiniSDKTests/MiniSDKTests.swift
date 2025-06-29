import XCTest
@testable import MiniSDK

final class MiniSDKTests: XCTestCase {
    
    func test_trackEvent_logsMessageCorrectly() {
        // GIVEN
        let logger = MockLogger()
        let tokenStore = MockTokenStore()
        let config = Configuration(apiKey: "test-key", environment: .development)
        let sdk = MiniSDK(
            configuration: config,
            logger: logger,
            tokenStore: tokenStore,
            lifecycleObserver: StubLifecycleObserver()
        )
        
        // WHEN
        sdk.trackEvent(name: "test_event", payload: ["key": "value"])
        
        // THEN
        XCTAssertEqual(logger.logs.count, 1)
        XCTAssertTrue(logger.logs[0].message.contains("test_event"))
        XCTAssertTrue(logger.logs[0].message.contains("key"))
        XCTAssertEqual(logger.logs[0].level, .info)
    }
    
    func test_sendPushToken_savesToken() {
        // GIVEN
        let logger = MockLogger()
        let tokenStore = MockTokenStore()
        let config = Configuration(apiKey: "test-key")
        let sdk = MiniSDK(
            configuration: config,
            logger: logger,
            tokenStore: tokenStore,
            lifecycleObserver: StubLifecycleObserver()
        )
        
        // WHEN
        sdk.sendPushToken(token: "1234567890")
        
        // THEN
        XCTAssertEqual(tokenStore.savedToken, "1234567890")
        XCTAssertTrue(logger.logs.last?.message.contains("Push Token Alındı") ?? false)
    }
}
