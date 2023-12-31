// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
      .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.1")),
      .package(url: "https://github.com/onevcat/Kingfisher.git", from: "6.3.0"),
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
      .package(url: "https://github.com/Juanpe/SkeletonView.git", from: "1.7.0"),
      .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0"),
      .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.6.0"),
      .package(url: "https://github.com/finnchristoffer/MovieDB-iOS-Core.git", from: Version(stringLiteral: "1.0.0")),
      .package(path: "Common"),
      .package(path: "Detail")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Home",
            dependencies: [
              "Common",
              "Detail",
              "Alamofire",
              "Kingfisher",
              "Swinject",
              "SkeletonView",
              .product(name: "RxSwift", package: "RxSwift"),
              .product(name: "RxCocoa", package: "RxSwift"),
              .product(name: "Core", package: "MovieDB-iOS-Core"),
              "SnapKit"
            ]),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]),
    ]
)
