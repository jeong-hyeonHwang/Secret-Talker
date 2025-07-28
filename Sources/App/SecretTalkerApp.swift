import SwiftUI

@main
struct SecretTalkerApp: App {
    init() {
        let configurables: [AppearanceConfigurable.Type] = [
            NavigationAppearance.self,
            TabBarAppearance.self
        ]

        configurables.forEach { $0.configure() }
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .tint(.primary)
        }
        .modelContainer(for: [
            CreatedSecretMessage.self,
            ScannedSecretMessage.self])
    }
}
