import SwiftUI

@main
struct SecretTalkerApp: App {
    init() {
        NavigationAppearance.configure()
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
