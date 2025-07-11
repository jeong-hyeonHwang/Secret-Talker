import SwiftUI

@main
struct SecretTalkerApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .tint(.primary)
        }
        .modelContainer(for: SecretMessage.self)
    }
}
