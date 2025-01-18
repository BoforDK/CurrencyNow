//
//  ExchangeRateItem.swift
//  AppUI
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import AppCore

public struct ExchangeRateItem: View {
    let exchangeRate: ExchangeRate
    let referenceCurrency: CurrencyCode?
    let amount: KeyPath<ExchangeRate, Double>
    let action: () -> Void

    public init(
        exchangeRate: ExchangeRate,
        referenceCurrency: CurrencyCode?,
        amount: KeyPath<ExchangeRate, Double>,
        action: @escaping () -> Void
    ) {
        self.exchangeRate = exchangeRate
        self.referenceCurrency = referenceCurrency
        self.amount = amount
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            label
        }
        .buttonStyle(.plain)
    }

    private var label: some View {
        HStack {
            VStack {
                compareItem(
                    lhs: exchangeRate.currencyCode.value,
                    rhs: referenceCurrency?.value ?? "-"
                )

                compareItem(
                    lhs: exchangeRate.currencyCode.flag,
                    rhs: referenceCurrency?.value.flag ?? "-"
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack {
                amountItem(exchangeRate[keyPath: amount])

                moveItem(exchangeRate.move)
            }
        }
    }

    private func compareItem(lhs: String, rhs: String) -> some View {
        HStack(spacing: 0) {
            Text(lhs)

            Text("x")

            Text(rhs)
        }
    }

    private func amountItem(_ amount: Double) -> some View {
        let formattedAmount = NumberFormatters.basicFormat.string(from: amount)

        return Text(formattedAmount ?? "-")
    }

    private func moveItem(_ move: Double) -> some View {
        let formattedMoveAmount = NumberFormatters.basicPercentFormat.string(from: move)

        return Text(formattedMoveAmount ?? "-")
            .padding(5)
            .frame(minWidth: 70)
            .background {
                if move < 0 {
                    Color.red
                } else if move > 0 {
                    Color.green
                } else {
                    Color.gray
                }
            }
            .cornerRadius(5)
    }
}

#if DEBUG
#Preview {
    ExchangeRateItem(
        exchangeRate: .mock(),
        referenceCurrency: .mock(),
        amount: \.cnbMid,
        action: {}
    )
}
#endif
