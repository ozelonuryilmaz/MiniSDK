public struct Configuration {
    public let apiKey: String
    public let environment: Environment
    
    public init(apiKey: String, environment: Environment = .production) {
        self.apiKey = apiKey
        self.environment = environment
    }
}
