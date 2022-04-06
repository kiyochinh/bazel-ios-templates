import Foundation

public class TLConsoleLogEngine: TLLoggingEngine {
    public func log(_ format: String, _ args: CVarArg...) {
        NSLog(format, args)
    }
    
    public init() {
        
    }
}
