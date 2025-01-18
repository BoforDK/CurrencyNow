import struct ProjectDescription.Configuration

public struct AppSetup {
    public static var current: Self {
        .init(environment: .current, configuration: .current)
    }

    public let environment: Environment
    public let configuration: Configuration
    public let moduleBundleIDPrefix = "com.currencynow"
    public let teamID: String = "YUZLMRGGBB"

    public var bundleID: String {
        switch (configuration, environment) {
        case (.debug, _):
            moduleBundleIDPrefix + ".debug"
        case (.beta, .development):
            moduleBundleIDPrefix + ".dev"
        case (.beta, .production):
            fatalError("Config: Beta, Environment: Production bundleID not configured")
        case (.release, .production):
            moduleBundleIDPrefix + ".prod"
        case (.release, .development):
            fatalError("Config: Release, Environment: Production bundleID not configured")
        }
    }

    public var appName: String {
        let appName = "CurrencyNow"

        if configuration == .release, environment == .production {
            return appName
        }

        return [
            appName,
            environment.appNameValue
        ].joined(separator: " ")
    }

    public var projectConfigurations: [ProjectDescription.Configuration] {
        switch configuration {
        case .debug:
            return [.debug(name: "Debug")]
        case .beta, .release:
            return [.release(name: "Release")]
        }
    }

    public var codeSignStyle: String = "Automatic"
}

extension AppSetup: CustomStringConvertible {
    public var description: String { "\(configuration)/\(environment)" }
}

