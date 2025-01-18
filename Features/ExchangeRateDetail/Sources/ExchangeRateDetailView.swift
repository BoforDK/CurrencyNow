//
//  ExchangeRateDetailView.swift
//  ExchangeRateDetail
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import ComposableArchitecture
import AppCore
import AppUI

public struct ExchangeRateDetailView: View {
    @Bindable private var store: StoreOf<ExchangeRateDetailFeature>
    
    @ScaledMetric(relativeTo: .body) var toolBarIconSize: CGFloat = 15
    
    public init(
        store: StoreOf<ExchangeRateDetailFeature>
    ) {
        self.store = store
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                ExchangeRateItem(
                    exchangeRate: store.exchangeRate,
                    referenceCurrency: store.referenceCurrency,
                    amount: \.cnbMid,
                    action: {}
                )
                
                item(
                    title: "Country",
                    description: store.exchangeRate.country
                )
                
                item(
                    title: "Name",
                    description: store.exchangeRate.name
                )
                
                if let validFrom = store.exchangeRate.validFrom {
                    item(
                        title: "Valid from",
                        description: DateFormatters.mediumDate.string(from: validFrom)
                    )
                }
            }
            .padding(10)
        }
        .navigationTitle(store.exchangeRate.name)
    }
    
    private func item(title: String, description: String) -> some View {
        HStack {
            Text(title + ":")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(description)
                .underline()
        }
    }
}

#if DEBUG
#Preview {
    ExchangeRateDetailView(
        store: .init(
            initialState: .init(
                exchangeRate: .mock(),
                referenceCurrency: .mock()
            ),
            reducer: EmptyReducer.init
        )
    )
}
#endif
