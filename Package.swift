// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FoundationExtension",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "FoundationExtension",
            targets: ["FoundationExtension"]
        )
    ],
    targets: [
        .target(
            name: "FoundationExtension",
            path: "Sources"
        )
    ]
)
