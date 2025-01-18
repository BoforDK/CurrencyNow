import ProjectDescription

private let targetName = "App"
private let bundleID = AppSetup.current.bundleID
private let sources: [SourceFileGlob] = [
    "\(targetName)/Sources/**"
].compactMap { $0 }

public let app: Target = .target(
    name: targetName,
    destinations: [.iPhone, .iPad],
    product: .app,
    bundleId: bundleID,
    infoPlist: .extendingDefault(
        with: [
            "CFBundleDisplayName": .string(AppSetup.current.appName),
            "UILaunchScreen": .dictionary([:]),
        ]
    ),
    sources: .sourceFilesList(globs: sources),
    dependencies: [
        .target(appCore),
        .target(appUI),
        
        .target(currencyList),
        .target(exchangeRateDetail),
    ],
    settings: .settings(
        base: [
            "DEVELOPMENT_TEAM": .string(AppSetup.current.teamID)
        ],
        configurations: AppSetup.current.projectConfigurations
    )
)
