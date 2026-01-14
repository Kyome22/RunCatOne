import Foundation
import Logging

public enum CriticalEvent {
    case failedToDoSomething(any Error)

    public var message: Logger.Message {
        switch self {
        case .failedToDoSomething:
            "Failed to do something."
        }
    }

    public var metadata: Logger.Metadata? {
        switch self {
        case let .failedToDoSomething(error):
            ["cause": "\(error.localizedDescription)"]
        }
    }
}
