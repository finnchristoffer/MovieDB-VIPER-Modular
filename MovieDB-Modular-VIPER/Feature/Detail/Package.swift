// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Detail",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Detail",
            targets: ["Detail"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
      .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.1")),
      .package(url: "https://github.com/onevcat/Kingfisher.git", from: "6.3.0"),
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
      .package(url: "https://github.com/Juanpe/SkeletonView.git", from: "1.7.0"),
      .package(url: "https://github.com/kishikawakatsumi/IBPCollectionViewCompositionalLayout.git", branch: "master"),
      .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0"),
      .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.6.0"),
      .package(url: "https://github.com/youtube/youtube-ios-player-helper.git", from: "1.0.4"),
      .package(url: "https://github.com/finnchristoffer/MovieDB-iOS-Core.git", from: Version(stringLiteral: "1.0.0")),
      .package(path: "Common")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Detail",
            dependencies: [
              "Common",
              "Alamofire",
              "Kingfisher",
              "Swinject",
              "SkeletonView",
              "IBPCollectionViewCompositionalLayout",
              .product(name: "RxSwift", package: "RxSwift"),
              .product(name: "RxCocoa", package: "RxSwift"),
              .product(name: "Core", package: "MovieDB-iOS-Core"),
              .product(name: "YouTubeiOSPlayerHelper", package: "youtube-ios-player-helper"),
              "SnapKit"
            ]),
        .testTarget(
            name: "DetailTests",
            dependencies: ["Detail"]),
    ]
)
