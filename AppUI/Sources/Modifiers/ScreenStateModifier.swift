//
//  ScreenStateModifier.swift
//  AppCore
//
//  Created by Alexander Grigorov on 18.01.2025.
//

import SwiftUI
import AppCore

private struct ScreenStateModifier: ViewModifier {
    let screenState: ScreenState

    func body(content: Content) -> some View {
        switch screenState {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded:
            content
        case .error:
            Text("Something went wrong")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

public extension View {
    func screenState(_ screenState: ScreenState) -> some View {
        modifier(
            ScreenStateModifier(screenState: screenState)
        )
    }
}
