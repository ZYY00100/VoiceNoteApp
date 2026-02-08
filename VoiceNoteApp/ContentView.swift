//
//  ContentView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @EnvironmentObject private var repository: NoteRepository
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedTab = 0

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.25)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        ZStack {
            AppBackgroundView(selectedTab: selectedTab)

            TabView(selection: $selectedTab) {
                NoteListView(repository: repository)
                    .tabItem {
                        Label("笔记", systemImage: "note.text")
                    }
                    .tag(0)

                SearchView(repository: repository, viewContext: viewContext)
                    .tabItem {
                        Label("搜索", systemImage: "magnifyingglass")
                    }
                    .tag(1)

                RecordingView(repository: repository)
                    .tabItem {
                        Label("录音", systemImage: "mic.circle.fill")
                    }
                    .tag(2)

                TagManagementView(repository: repository, viewContext: viewContext)
                    .tabItem {
                        Label("标签", systemImage: "tag.fill")
                    }
                    .tag(3)
            }
            .background(Color.clear)
            .toolbarBackground(.hidden, for: .tabBar)
        }
        .accentColor(.blue)
    }
}

#Preview {
    let context = PersistenceController(inMemory: true).container.viewContext
    let repo = NoteRepository(context: context)
    return ContentView()
        .environment(\.managedObjectContext, context)
        .environmentObject(repo)
}
