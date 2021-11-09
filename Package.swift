// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Indicate",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Indicate",
            targets: ["Indicate"]),
    ],
    dependencies: [
        // no dependencies
    ],
    targets: [
        .target(
            name: "Indicate",
            dependencies: [])
    ]
)
