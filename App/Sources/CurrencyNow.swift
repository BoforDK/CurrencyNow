import ComposableArchitecture
import SwiftUI

@main
struct CurrencyNow: App {
    var body: some Scene {
        WindowGroup {
            RootFlowDelegate(
                store: Store(initialState: RootFlowDelegateFeature.State()) {
                    RootFlowDelegateFeature()
                }
            )
        }
    }
}
