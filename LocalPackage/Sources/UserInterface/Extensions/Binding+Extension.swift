import SwiftUI

extension Binding where Value : Sendable {
    @preconcurrency init(
        @_inheritActorContext get: @escaping @isolated(any) @Sendable () -> Value,
        @_inheritActorContext asyncSet: @escaping @isolated(any) @Sendable (Value) async -> Void
    ) {
        self.init(get: get, set: { newValue in Task { await asyncSet(newValue) } })
    }
}
