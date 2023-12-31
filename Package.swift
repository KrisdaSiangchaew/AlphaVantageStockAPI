// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlphaVantageStockAPI",
    platforms: [
        .iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8)
    ],
    products: [
        .library(
            name: "AlphaVantageStockAPI",
            targets: ["AlphaVantageStockAPI"]),
        .executable(
            name: "APIExec",
            targets: ["APIExec"])
    ],
    targets: [
        .target(
            name: "AlphaVantageStockAPI",
            dependencies: []),
        .executableTarget(
            name: "APIExec",
            dependencies: ["AlphaVantageStockAPI"]),
        .testTarget(
            name: "AlphaVantageStockAPITests",
            dependencies: ["AlphaVantageStockAPI"]),
    ]
)
