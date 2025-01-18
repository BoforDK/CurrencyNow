import ProjectDescription

private let targetName = "ExchangeRateList"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).\(targetName)"

public let exchangeRateList: Target = .target(
    name: targetName,
    destinations: [.iPhone, .iPad],
    product: .framework,
    bundleId: bundleID,
    infoPlist: .default,
    sources: "Features/\(targetName)/Sources/**",
    dependencies: [
        .target(appUI),
        .target(appCore),
        .target(appDependencies),
    ]
)

public let exchangeRateListTests: Target = .target(
    name: "\(targetName)Tests",
    destinations: [.iPhone, .iPad],
    product: .unitTests,
    bundleId: "\(bundleID).tests",
    infoPlist: .default,
    sources: ["Features/\(targetName)/Tests/**"],
    resources: [],
    dependencies: [
        .xctest,
        .target(exchangeRateList),
        .snapshotTesting,
    ]
)

