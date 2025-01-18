import ProjectDescription

private let targetName = "CurrencyList"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).\(targetName)"
private let sources: [SourceFileGlob] = [
    "Features/\(targetName)/Sources/**",
    Configuration.current == .debug ? "Features/\(targetName)/Testing/**" : nil,
].compactMap { $0 }

public let currencyList: Target = .target(
    name: targetName,
    destinations: [.iPhone, .iPad],
    product: .framework,
    bundleId: bundleID,
    infoPlist: .default,
    sources: .sourceFilesList(globs: sources),
    dependencies: [
        .target(appCore),
        .target(appUI),
    ]
)

public let currencyListTests: Target = .target(
    name: "\(targetName)Tests",
    destinations: [.iPhone, .iPad],
    product: .unitTests,
    bundleId: "\(bundleID).tests",
    infoPlist: .default,
    sources: ["Features/\(targetName)/Tests/**"],
    resources: [],
    dependencies: [
        .xctest,
        .target(currencyList),
        .snapshotTesting,
    ]
)

