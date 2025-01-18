import ProjectDescription

private let targetName = "AppUI"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).ui"

// MARK: - Target

public let appUI = Target.target(
    name: targetName,
    destinations: [.iPhone, .iPad],
    product: .framework,
    bundleId: bundleID,
    infoPlist: .default,
    sources: "\(targetName)/Sources/**",
    resources: ["\(targetName)/Resources/**"],
    entitlements: nil,
    dependencies: [
        .target(appCore),
    ]
)

public let appUITests: Target = .target(
    name: "\(targetName)Tests",
    destinations: [.iPhone, .iPad],
    product: .unitTests,
    bundleId: "\(bundleID).tests",
    infoPlist: .default,
    sources: ["\(targetName)/Tests/**"],
    resources: [],
    dependencies: [
        .xctest,
        .target(appUI),
        .snapshotTesting,
    ]
)


