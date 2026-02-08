//
//  VoiceNoteApp.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import SwiftUI
import CoreData

@main
struct VoiceNoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(NoteRepository(context: persistenceController.container.viewContext))
        }
    }
}
