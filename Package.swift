// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
import Foundation

let package : Package

#if os(Linux)
let isLinux = true
#else
let isLinux = false
#endif
let app =  ProcessInfo.processInfo.environment["APP"] ?? ""

if isLinux && app != "" {

let username = ProcessInfo.processInfo.environment["GITHUBNAME"] ?? ""
let password =  ProcessInfo.processInfo.environment["GITHUBSECRET"] ?? ""
package = Package(
    name: "EventService",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "EventService",
            targets: ["EventService"]),
    ],
    dependencies: [

        .package(url: "https://\(username):\(password)@github.com/adirburke/Zara-Logger.git", .branch("master")),
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "EventService",
            dependencies: ["Zara-Logger"]),
    ]
)
} else {
package = Package(
    name: "EventService",
    platforms: [
        // .macOS(.v10_15),
         .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "EventService",
            targets: ["EventService"]),
    ],
    dependencies: [

        .package(url: "https://github.com/adirburke/Zara-Logger.git", .branch("master")),
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "EventService",
            dependencies: ["Zara-Logger"]),
    ]
)
}
