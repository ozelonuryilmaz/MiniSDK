import Foundation

public protocol SDKLoggerProtocol {
    var currentLevel: LogLevel { get set }
    func log(_ message: String, level: LogLevel)
}

public struct SDKLogger: SDKLoggerProtocol {
    public var currentLevel: LogLevel
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter
    }()
    
    public init(level: LogLevel = .debug) {
        self.currentLevel = level
    }
    
    public func log(_ message: String, level: LogLevel) {
        guard level >= currentLevel else { return }
        
        let timestamp = dateFormatter.string(from: Date())
        print("[MiniSDK][\(level.prefix)][\(timestamp)] \(message)")
    }
}
