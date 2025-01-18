import ProjectDescription

private let targetName = "ExchangeRateDetail"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).\(targetName)"

public let exchangeRateDetail: Target = .target(
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
