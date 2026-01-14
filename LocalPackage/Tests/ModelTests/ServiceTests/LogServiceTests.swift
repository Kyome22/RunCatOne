import os
import Testing

@testable import DataSource
@testable import Model

struct LogServiceTests {
    @Test
    func bootstrap_executed_only_once() {
        let appState = OSAllocatedUnfairLock<AppState>(initialState: .init())
        let count = OSAllocatedUnfairLock(initialState: 0)
        let sut = LogService(.testDependencies(
            appStateClient: .testDependency(appState),
            loggingSystemClient: testDependency(of: LoggingSystemClient.self) {
                $0.bootstrap = { _ in count.withLock { $0 += 1  } }
            }
        ))
        sut.bootstrap()
        sut.bootstrap()
        let actual = count.withLock(\.self)
        #expect(actual == 1)
    }
}
