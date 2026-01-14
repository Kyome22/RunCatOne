import os

public struct AppStateClient: DependencyClient {
    var getAppState: @Sendable () -> AppState
    var setAppState: @Sendable (AppState) -> Void

    public func withLock<R: Sendable>(_ body: @Sendable (inout AppState) throws -> R) rethrows -> R {
        var state = getAppState()
        let result = try body(&state)
        setAppState(state)
        return result
    }

    public static let liveValue: Self = {
        let state = OSAllocatedUnfairLock<AppState>(initialState: .init())
        return Self(
            getAppState: { state.withLock(\.self) },
            setAppState: { value in state.withLock { $0 = value } }
        )
    }()

    public static let testValue = Self(
        getAppState: { .init() },
        setAppState: { _ in }
    )

    public static func testDependency(_ appState: OSAllocatedUnfairLock<AppState>) -> Self {
        Self(
            getAppState: { appState.withLock(\.self) },
            setAppState: { value in appState.withLock { $0 = value } }
        )
    }
}
