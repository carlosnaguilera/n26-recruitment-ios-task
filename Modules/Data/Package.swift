// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                "Domain"
            ],
            resources: [
                .process("RemoteDataSource/Resources/assets_list_response.json"),
                .process("RemoteDataSource/Resources/rates_response.json"),
            ]),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]
        ),
    ]
)
