//
//  NoteRepository.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import CoreData
import Combine

class NoteRepository: ObservableObject {
    let context: NSManagedObjectContext
    @Published var notes: [Note] = []

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchNotes()
    }

    func fetchNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Note.createdAt, ascending: false)]

        do {
            notes = try context.fetch(request)
        } catch {
            print("Error fetching notes: \(error)")
        }
    }

    func createNote(title: String, originalContent: String, summaryContent: String = "", audioURL: String? = nil, duration: Double = 0) -> Note {
        let note = Note(context: context)
        note.id = UUID()
        note.title = title
        note.originalContent = originalContent
        note.summaryContent = summaryContent
        note.audioURL = audioURL
        note.createdAt = Date()
        note.duration = duration
        note.isTodo = false

        saveContext()
        fetchNotes()

        return note
    }

    func updateNote(_ note: Note, title: String? = nil, originalContent: String? = nil, summaryContent: String? = nil, isTodo: Bool? = nil) {
        if let title = title { note.title = title }
        if let originalContent = originalContent { note.originalContent = originalContent }
        if let summaryContent = summaryContent { note.summaryContent = summaryContent }
        if let isTodo = isTodo { note.isTodo = isTodo }

        saveContext()
        fetchNotes()
    }

    func deleteNote(_ note: Note) {
        context.delete(note)
        saveContext()
        fetchNotes()
    }

    func addTag(_ tag: Tag, to note: Note) {
        var tags = note.tagsArray
        if !tags.contains(where: { $0.id == tag.id }) {
            note.mutableSetValue(forKey: "tags").add(tag)
            saveContext()
            fetchNotes()
        }
    }

    func removeTag(_ tag: Tag, from note: Note) {
        note.mutableSetValue(forKey: "tags").remove(tag)
        saveContext()
        fetchNotes()
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}
