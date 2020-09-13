// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "FitnessAPI",
    products: [
        .library(name: "FitnessAPI", targets: ["FitnessAPI"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .exact("4.9.0")),
    ],
    targets: [
        .target(name: "FitnessAPI", dependencies: [
          "Alamofire",
        ], path: "Sources")
    ]
)
