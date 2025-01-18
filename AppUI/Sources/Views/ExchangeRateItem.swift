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
    let comparedCurrency: CurrencyCode?

    public init(
        exchangeRate: ExchangeRate,
        comparedCurrency: CurrencyCode?
    ) {
        self.exchangeRate = exchangeRate
        self.comparedCurrency = comparedCurrency
    }

    public var body: some View {
        HStack {
            VStack {
                compareItem(
                    lhs: exchangeRate.currencyCode.value,
                    rhs: comparedCurrency?.value ?? "-"
                )

                compareItem(
                    lhs: exchangeRate.currencyCode.flag,
                    rhs: comparedCurrency?.value.flag ?? "-"
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack {
                amountItem(exchangeRate.currMid)

                moveItem(exchangeRate.move)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
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
        comparedCurrency: .mock()
    )
}
#endif
