import Model
import SwiftUI

public struct ContentScene: Scene {
    @Environment(\.appDependencies) private var appDependencies

    public init() {}

    public var body: some Scene {
        WindowGroup {
            ContentView(store: .init(appDependencies))
        }
    }
}
