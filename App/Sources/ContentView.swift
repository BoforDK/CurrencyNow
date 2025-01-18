import SwiftUI
import AppCore
import ComposableArchitecture

struct ContentView: View {
    @Bindable var store: StoreOf<ContentFeature>

    var body: some View {
        Text("Hello, world!")
    }
}

#Preview {
    ContentView(
        store: .init(
            initialState: .init(),
            reducer: EmptyReducer.init
        )
    )
}
