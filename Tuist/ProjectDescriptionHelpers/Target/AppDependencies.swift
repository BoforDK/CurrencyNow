import ProjectDescription

private let targetName = "AppDependencies"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).ui"
private let sources: [SourceFileGlob] = [
    "\(targetName)/Sources/**",
    Configuration.current == .debug ? "\(targetName)/Testing/**" : nil,
].compactMap { $0 }

// MARK: - Target

public let appDependencies = Target.target(
    name: targetName,
    destinations: [.iPhone, .iPad],
    product: .framework,
    bundleId: bundleID,
    infoPlist: .default,
    sources: .sourceFilesList(globs: sources),
    entitlements: nil,
    dependencies: [
        .target(appCore),
    ]
)
