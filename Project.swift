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
                    "NSCameraUsageDescription": "QR 코드를 인식하기 위해 카메라 접근이 필요합니다.",
                    "UIAppFonts": [
                        "Orbitron-Regular.ttf",
                        "Orbitron-Bold.ttf"
                    ]
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [
                .pre(script:"""
            export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH
            if which swiftlint >/dev/null; then
              swiftlint
            else
              echo "warning: SwiftLint not installed"
            fi
            """, name: "SwiftLint")
            ],
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
