@testable import MiniSDK

final class MockLogger: SDKLoggerProtocol {
    var logs: [(message: String, level: LogLevel)] = []
    var currentLevel: LogLevel = .debug
    
    func log(_ message: String, level: LogLevel) {
        logs.append((message, level))
    }
}
