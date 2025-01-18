//
//  ExchangeRateList.swift
//  CurrencyNow
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import XCTest
import SwiftUI
import ComposableArchitecture
import SnapshotTesting
import AppCore

@testable import ExchangeRateList

final class ExchangeRateListTest: XCTestCase {
    public func test_snapshot() {
        let view = ExchangeRateListView(
            store: .init(
                initialState: .init(
                    screenState: .loaded,
                    currencies: .mock,
                    exchangeRates: .mock,
                    selectedCurrency: .mock()
                ),
                reducer: EmptyReducer.init
            )
        )

        let viewController = UIHostingController(rootView: view)

        assertSnapshot(of: viewController, as: .image(on: .iPhone13))
    }
}
