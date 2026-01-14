import Logging

public enum ErrorEvent {
    case none

    public var message: Logger.Message { "" }
    public var metadata: Logger.Metadata? { nil }
}
