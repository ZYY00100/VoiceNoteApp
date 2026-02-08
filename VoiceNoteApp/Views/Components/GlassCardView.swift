//
//  GlassCardView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-06.
//

import SwiftUI

struct GlassCardView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.white.opacity(0.35), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [Color(red: 0.96, green: 0.97, blue: 1.00), Color(red: 0.88, green: 0.92, blue: 1.00)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        GlassCardView {
            VStack(spacing: 8) {
                Text("VoiceNote")
                    .font(.headline)
                Text("Glass card preview")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(24)
    }
}
