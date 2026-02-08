//
//  AppLogoView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-06.
//

import SwiftUI

struct AppLogoView: View {
    var size: CGFloat = 96

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.12, green: 0.14, blue: 0.20),
                            Color(red: 0.20, green: 0.24, blue: 0.32)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.28, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.65),
                                    Color.white.opacity(0.10)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: size * 0.02
                        )
                )

            VStack(spacing: size * 0.08) {
                Capsule()
                    .fill(Color.white.opacity(0.9))
                    .frame(width: size * 0.12, height: size * 0.38)

                RoundedRectangle(cornerRadius: size * 0.08, style: .continuous)
                    .fill(Color.white.opacity(0.75))
                    .frame(width: size * 0.36, height: size * 0.10)
            }

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.93, green: 0.76, blue: 0.42),
                            Color(red: 0.86, green: 0.56, blue: 0.30)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.16, height: size * 0.16)
                .offset(x: size * 0.18, y: -size * 0.18)
        }
        .frame(width: size, height: size)
        .shadow(color: .black.opacity(0.18), radius: size * 0.10, x: 0, y: size * 0.05)
    }
}

#Preview {
    AppLogoView(size: 110)
}
