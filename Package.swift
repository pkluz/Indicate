// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Indicate",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14)
    ],
    products: [
        .library(name: "Indicate", targets: ["Indicate"])
    ],
    targets: [
        .target(
            name: "Indicate",
            path: "Indicate",
            exclude: [
                "Supporting Files/Info.plist",
                "Resources/Base.lproj/LaunchScreen.storyboard"
            ]
        )
    ]
)
