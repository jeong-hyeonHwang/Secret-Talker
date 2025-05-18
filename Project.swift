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
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
        ),
        .target(
            name: "SecretTalkerTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.SecretTalkerTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "SecretTalker")]
        ),
    ]
)
