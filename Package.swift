// swift-tools-version:5.4
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
                "Indicate/SupportingFiles/Info.plist",
                "Indicate/Resources/Base.lproj/LaunchScreen.storyboard"
            ]
        )
    ]
)
