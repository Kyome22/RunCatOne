import Observation

@MainActor
public protocol Composable: AnyObject {
    associatedtype Action: Sendable

    var action: (Action) async -> Void { get }

    func reduce(_ action: Action) async
}

public extension Composable {
    func reduce(_ action: Action) async {}

    func send(_ action: Action) async {
        await reduce(action)
        await self.action(action)
    }
}
