import Model
import SwiftUI

struct ContentView: View {
    @StateObject var store: ContentStore

    var body: some View {
        List {
            Section {
                LabeledContent("App Name", value: store.appName)
                LabeledContent("App Version", value: store.appVersion)
            } header: {
                Text("Environment")
            }
            Section {
                LabeledContent("Counter: \(store.count)") {
                    Button("Add") {
                        Task { await store.send(.plusButtonTapped) }
                    }
                }
                Toggle(isOn: Binding<Bool>(
                    get: { store.isEnabled },
                    asyncSet: { await store.send(.isEnabledToggleSwitched($0)) }
                )) {
                    Text("Flag")
                }
            } header: {
                Text("Sample Action")
            }
        }
        .task {
            await store.send(.task(String(describing: Self.self)))
        }
    }
}

extension ContentStore: ObservableObject {}
