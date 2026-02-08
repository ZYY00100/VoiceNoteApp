//
//  AppScreenStyle.swift
//  VoiceNoteApp
//
//  Created on 2026-02-06.
//

import SwiftUI

struct AppScreenStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.clear)
            .toolbarBackground(.hidden, for: .navigationBar)
    }
}

extension View {
    func appScreenStyle() -> some View {
        modifier(AppScreenStyle())
    }
}

