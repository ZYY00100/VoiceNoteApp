//
//  TagManagementViewModel.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import CoreData
import SwiftUI

class TagManagementViewModel: ObservableObject {
    @Published var tags: [Tag] = []
    @Published var showingAddTag = false
    @Published var newTagName = ""
    @Published var selectedColor = "blue"

    private let context: NSManagedObjectContext
    private let repository: NoteRepository

    let availableColors = ["red", "orange", "yellow", "green", "blue", "purple", "pink"]

    init(context: NSManagedObjectContext, repository: NoteRepository) {
        self.context = context
        self.repository = repository
        fetchTags()
    }

    func fetchTags() {
        let request: NSFetchRequest<Tag> = Tag.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Tag.name, ascending: true)]

        do {
            tags = try context.fetch(request)
        } catch {
            print("Error fetching tags: \(error)")
        }
    }

    func createTag() {
        guard !newTagName.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }

        let tag = Tag(context: context)
        tag.id = UUID()
        tag.name = newTagName.trimmingCharacters(in: .whitespaces)
        tag.color = selectedColor

        do {
            try context.save()
            fetchTags()
            newTagName = ""
            showingAddTag = false
        } catch {
            print("Error saving tag: \(error)")
        }
    }

    func deleteTag(_ tag: Tag) {
        context.delete(tag)

        do {
            try context.save()
            fetchTags()
        } catch {
            print("Error deleting tag: \(error)")
        }
    }

    func updateTag(_ tag: Tag, name: String, color: String) {
        tag.name = name
        tag.color = color

        do {
            try context.save()
            fetchTags()
        } catch {
            print("Error updating tag: \(error)")
        }
    }
}
