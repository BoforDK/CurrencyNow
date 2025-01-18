import ComposableArchitecture
import SwiftUI

@main
struct CurrencyNow: App {
    let store = Store(initialState: RootFlowDelegateFeature.State()) {
        RootFlowDelegateFeature()
    }

    var body: some Scene {
        WindowGroup {
            RootFlowDelegate(
                store: store
            )
        }
    }
}
