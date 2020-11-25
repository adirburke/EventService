import Foundation
import Zara_Logger




public  struct EventManager {
    let service : String
    let eventId : UUID
    let logger : LogService
    
//    private let logger : LogService
    
    public init(service name : String, eventId : UUID = UUID()) {
        self.service = name
        self.eventId = eventId
        self.logger = LogService(name: name, withStart: false)
    }
    
    
    
    public func logError(eventId : UUID? = nil,  message : String) {
        let logger : LogService
        if let eventId = eventId {
            logger = LogService(name: eventId.uuidString, withStart: false)
        } else {
            logger = LogService(name: self.service, withStart: false)
        }
       
        logger.logMessage("Error:: > \(service) -> \(message)", console: false)
    }
    
    public func logEvent<T>(eventId : UUID? = nil, message : String = "", item : T) where T : Encodable {
        if let eventId  = eventId {
            let logger = LogService(name: eventId.uuidString, withStart: false)
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(item), let parmsString = String(data: data, encoding:  .utf8) {
                logger.logMessage("\(service) ->\(message) - \(parmsString)", console: false)
            } else {
                
                logger.logMessage("\(service) -> \(message)", console: false)
            }
        } else {
            logMain(message: message, item: item)
        }
    }
    public func logEvent<T>(eventId : UUID? = nil, message : String = "", items: T...) where T : Encodable {
        if let eventId = eventId {
            let logger = LogService(name: eventId.uuidString, withStart: false)
            let encoder = JSONEncoder()
            for i in items {
                if let data = try? encoder.encode(i), let parmsString = String(data: data, encoding:  .utf8) {
                    logger.logMessage("\(service) ->\(message) - \(parmsString)", console: false)
                } else {
                    
                    logger.logMessage("\(service) -> \(message)", console: false)
                }
            }
        } else {
            logMain(message: message, item: items)
        }
    }
    
    public func logEvent(eventId : UUID? = nil, message : String = "") {
        if let eventId = eventId {
        let logger = LogService(name: eventId.uuidString, withStart: false)
        logger.logMessage("\(service) -> \(message)", console: false)
        } else {
            logMain(message: message)
        }
    }
    
    public func logMain<T>(message : String = "", item: T...) where T : Encodable {
//        let eventId = self.eventId
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(item), let parmsString = String(data: data, encoding:  .utf8) {
            logger.logMessage("\(service) ->\(message) - \(parmsString)", console: false)
        } else {
            logger.logMessage("\(service) -> \(message)", console: false)
        }
    }
    public func logMain(message : String) {
        logger.logMessage("\(service) -> \(message)", console: false)
    }
    
}
