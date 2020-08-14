import Foundation
import Zara_Logger




public final class EventManager {
    let service : String
    
    public init(service name : String) {
        self.service = name
    }
    
    public func logError(eventId : UUID,  message : String) {
        
    }
    
    public func logEvent<T>(eventId : UUID, message : String = "", item : T) where T : Encodable {
        
    }
    public func logEvent(eventId : UUID, message : String = "") {
        
    }
}
