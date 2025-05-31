import SwiftUI

@main
struct SecretTalkerApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: SecretMessage.self)
    }
}
