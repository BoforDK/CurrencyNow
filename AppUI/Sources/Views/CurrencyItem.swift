//
//  CurrencyItem.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import AppCore

public struct CurrencyItem: View {
    private var currency: Currency
    private var action: () -> Void

    public init(
        currency: Currency,
        action: @escaping () -> Void
    ) {
        self.currency = currency
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack {
                Text(currency.currencyCode.flag)

                VStack(alignment: .leading) {
                    Text(currency.longName)
                    Text(currency.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Text(currency.currencyCode.value)
            }
        }
        .padding(5)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .buttonStyle(.plain)
    }
}

#if DEBUG
#Preview {
    CurrencyItem(
        currency: .mock(),
        action: {}
    )
}
#endif
