import Foundation
import Zara_Logger




public  struct EventManager {
    let service : String
    
//    private let logger : LogService
    
    public init(service name : String) {
        self.service = name
    }
    
    public func logError(eventId : UUID,  message : String) {
        let logger = LogService(name: eventId.uuidString, withStart: false)
        logger.logMessage("Error:: > \(service) -> \(message)", console: false)
    }
    
    public func logEvent<T>(eventId : UUID, message : String = "", item : T) where T : Encodable {
        let logger = LogService(name: eventId.uuidString)
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(item), let parmsString = String(data: data, encoding:  .utf8) {
            logger.logMessage("\(service) ->\(message) - \(parmsString)", console: false)
        } else {
        
            logger.logMessage("\(service) -> \(message)", console: false)
        }
    }
    public func logEvent<T>(eventId : UUID, message : String = "", items: T...) where T : Encodable {
        let logger = LogService(name: eventId.uuidString)
        let encoder = JSONEncoder()
        for i in items {
            if let data = try? encoder.encode(i), let parmsString = String(data: data, encoding:  .utf8) {
                logger.logMessage("\(service) ->\(message) - \(parmsString)", console: false)
            } else {
            
                logger.logMessage("\(service) -> \(message)", console: false)
            }
        }
    }
    
    public func logEvent(eventId : UUID, message : String = "") {
        let logger = LogService(name: eventId.uuidString, withStart: false)
        logger.logMessage("\(service) -> \(message)", console: false)
    }
}
