//
//  AppBackgroundView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-06.
//

import SwiftUI

struct AppBackgroundView: View {
    let selectedTab: Int

    var body: some View {
        LinearGradient(
            colors: gradientColors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.35), value: selectedTab)
    }

    private var gradientColors: [Color] {
        switch selectedTab {
        case 0:
            return [
                Color(red: 0.96, green: 0.97, blue: 1.00),
                Color(red: 0.88, green: 0.92, blue: 1.00)
            ]
        case 1:
            return [
                Color(red: 0.95, green: 0.98, blue: 0.97),
                Color(red: 0.87, green: 0.96, blue: 0.93)
            ]
        case 2:
            return [
                Color(red: 0.99, green: 0.96, blue: 0.93),
                Color(red: 0.98, green: 0.90, blue: 0.86)
            ]
        case 3:
            return [
                Color(red: 0.96, green: 0.95, blue: 0.99),
                Color(red: 0.90, green: 0.88, blue: 0.98)
            ]
        default:
            return [
                Color(red: 0.97, green: 0.97, blue: 0.98),
                Color(red: 0.92, green: 0.92, blue: 0.95)
            ]
        }
    }
}

#Preview {
    AppBackgroundView(selectedTab: 0)
}
