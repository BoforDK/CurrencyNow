import ProjectDescription

private let targetName = "AppCore"
private let bundleID = "\(AppSetup.current.moduleBundleIDPrefix).core"
private let sources: [SourceFileGlob] = [
    "\(targetName)/Sources/**",
    Configuration.current == .debug ? "\(targetName)/Testing/**" : nil,
].compactMap { $0 }

// MARK: - Target

public let appCore = Target.target(
    name: targetName,
    destinations: [.iPhone, .iPad],
    product: .framework,
    bundleId: bundleID,
    infoPlist: .default,
    sources: .sourceFilesList(globs: sources),
    entitlements: nil,
    scripts: [
        .post(
            script: """
                $HOME/.local/bin/mise exec -- swiftlint --fix
                $HOME/.local/bin/mise exec -- swiftlint
                """,
            name: "SwiftLint",
            basedOnDependencyAnalysis: false
        )
    ],
    dependencies: [
        .composableArchitecture,
    ]
)

public let appCoreTests: Target = .target(
    name: "\(targetName)Tests",
    destinations: [.iPhone, .iPad],
    product: .unitTests,
    bundleId: "\(bundleID).tests",
    infoPlist: .default,
    sources: ["\(targetName)/Tests/**"],
    resources: [],
    dependencies: [
        .xctest,
        .target(appCore),
    ]
)


