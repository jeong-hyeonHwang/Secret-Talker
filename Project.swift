import ProjectDescription

let project = Project(
    name: "SecretTalker",
    targets: [
        .target(
            name: "SecretTalker",
            destinations: .iOS,
            product: .app,
            bundleId: "com.jhHwang.SecretTalker",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen",
                    "NSCameraUsageDescription": "QR 코드를 인식하기 위해 카메라 접근이 필요합니다."
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
            bundleId: "com.jhHwang.SecretTalkerTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "SecretTalker")]
        )
    ]
)
