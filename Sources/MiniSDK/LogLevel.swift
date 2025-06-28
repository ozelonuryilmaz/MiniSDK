public enum LogLevel: Int, Comparable {
    case debug = 0
    case info
    case warning
    case error
    case critical
    
    public var prefix: String {
        switch self {
        case .debug:    return "DEBUG"
        case .info:     return "INFO"
        case .warning:  return "WARNING"
        case .error:    return "ERROR"
        case .critical: return "CRITICAL"
        }
    }
    
    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
