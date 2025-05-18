import ProjectDescription

let project = Project(
    name: "SecretTalker",
    targets: [
        .target(
            name: "SecretTalker",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.SecretTalker",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen"
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [],
            settings: .settings(
                base: [
                    "CODE_SIGN_IDENTITY": "",
                    "CODE_SIGNING_REQUIRED": "NO",
                    "CODE_SIGNING_ALLOWED": "NO",
                    "DEVELOPMENT_TEAM": ""
                ]
            )
        ),
        .target(
            name: "SecretTalkerTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.SecretTalkerTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "SecretTalker")],
            settings: .settings(
                base: [
                    "CODE_SIGN_IDENTITY": "",
                    "CODE_SIGNING_REQUIRED": "NO",
                    "CODE_SIGNING_ALLOWED": "NO",
                    "DEVELOPMENT_TEAM": ""
                ]
            )
        )
    ]
)
