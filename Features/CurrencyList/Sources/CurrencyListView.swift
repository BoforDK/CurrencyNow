//
//  CurrencyListView.swift
//  CurrencyList
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import AppCore
import ComposableArchitecture

public struct CurrencyListView: View {
    @Bindable var store: StoreOf<CurrencyListFeature>
    
    public init(store: StoreOf<CurrencyListFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack {
            Text("Currency")
            
            Button("Go to detail") {
                store.send(.goToDetail)
            }
        }
    }
}

#if DEBUG
#Preview {
    CurrencyListView(
        store: .init(
            initialState: .init(),
            reducer: EmptyReducer.init
        )
    )
}
#endif
