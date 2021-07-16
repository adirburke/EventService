import Foundation
import Zara_Logger
import Logging



public struct EventManager : LogHandler {
    public subscript(metadataKey key: String) -> Logger.Metadata.Value? {
        get { return self.metadata[key] }
        set { self.metadata[key] = newValue }
    }
    
    public var metadata: Logger.Metadata
    
    public var logLevel: Logger.Level
    
    let service : String
    let eventId : UUID
    let logger : LogService
    public var label : String = ""

    
    public init(service name : String, eventId : UUID = UUID(), level: Logger.Level = .info, metadata: Logger.Metadata = [:]) {
        self.service = name
        self.eventId = eventId
        self.logger = LogService(name: name, withStart: false)
        self.logLevel = level
        self.metadata = metadata
        
    }
    
    public func log(level: Logger.Level,
                    message: Logger.Message,
                    metadata: Logger.Metadata?,
                    source: String,
                    file: String,
                    function: String,
                    line: UInt) {
        
        var text = ""
        
        
        if self.logLevel <= .trace {
            text += "[ \(self.label) ] "
        }
        
        text += "[ \(level.name) ]"
            + " "
            + message.description
        
        
        self.logMain(message: text, console: true)
        
    }
    
    
    
    
    public func logError(eventId : UUID? = nil,  message : String, console : Bool = false) {
        let logger : LogService
        if let eventId = eventId {
            logger = LogService(name: eventId.uuidString, withStart: false)
        } else {
            logger = LogService(name: self.service, withStart: false)
        }
       
        logger.logMessage("Error:: > \(service) -> \(message)", console: console)
    }
    
    public func logEvent<T>(eventId : UUID? = nil, message : String = "", item : T, console : Bool = false) where T : Encodable {
        if let eventId  = eventId {
            let logger = LogService(name: eventId.uuidString, withStart: false)
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(item), let parmsString = String(data: data, encoding:  .utf8) {
                logger.logMessage("\(service) ->\(message) - \(parmsString)", console: console)
            } else {
                
                logger.logMessage("\(service) -> \(message)", console: console)
            }
        } else {
            logMain(message: message, item: item, console: console)
        }
    }
    public func logEvent<T>(eventId : UUID? = nil, message : String = "", items: T..., console : Bool = false) where T : Encodable {
        if let eventId = eventId {
            let logger = LogService(name: eventId.uuidString, withStart: false)
            let encoder = JSONEncoder()
            for i in items {
                if let data = try? encoder.encode(i), let parmsString = String(data: data, encoding:  .utf8) {
                    logger.logMessage("\(service) ->\(message) - \(parmsString)", console: console)
                } else {
                    
                    logger.logMessage("\(service) -> \(message)", console: console)
                }
            }
        } else {
            logMain(message: message, item: items, console: console)
        }
    }
    
    public func logEvent(eventId : UUID? = nil, message : String = "", console : Bool = false) {
        if let eventId = eventId {
        let logger = LogService(name: eventId.uuidString, withStart: false)
        logger.logMessage("\(service) -> \(message)", console: console)
        } else {
            logMain(message: message)
        }
    }
    
    public func logMain<T>(message : String = "", item: T..., console : Bool = false) where T : Encodable {
//        let eventId = self.eventId
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(item), let parmsString = String(data: data, encoding:  .utf8) {
            logger.logMessage("\(service) ->\(message) - \(parmsString)", console: console)
        } else {
            logger.logMessage("\(service) -> \(message)", console: console)
        }
    }
    public func logMain(message : String, console : Bool = false) {
        logger.logMessage("\(service) -> \(message)", console: console)

    }
    
}


extension Logger.Level {
    /// Converts log level to console style
    
    public var name: String {
        switch self {
        case .trace: return "TRACE"
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .notice: return "NOTICE"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        case .critical: return "CRITICAL"
        }
    }
}
