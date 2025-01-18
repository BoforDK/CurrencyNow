import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "CurrencyNow",
    settings: .settings(
        base: [
            "IPHONEOS_DEPLOYMENT_TARGET": "18.0"
        ]
    ),
    targets: [
        app,
        appCore,
        appCoreTests,
        appUI,
        appUITests,
        appDependencies,
        
        exchangeRateList,
        exchangeRateListTests,
        
        exchangeRateDetail,
    ]
)
