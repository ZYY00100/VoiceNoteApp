//
//  SearchService.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import CoreData
import Combine

class SearchService: ObservableObject {
    @Published var searchResults: [Note] = []
    @Published var selectedTag: Tag?
    @Published var isSearching = false

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func search(query: String, filterTag: Tag? = nil) {
        guard !query.isEmpty || filterTag != nil else {
            searchResults = []
            return
        }

        isSearching = true

        let request: NSFetchRequest<Note> = Note.fetchRequest()
        var predicates: [NSPredicate] = []

        if !query.isEmpty {
            let titlePredicate = NSPredicate(format: "title CONTAINS[cd] %@", query)
            let contentPredicate = NSPredicate(format: "originalContent CONTAINS[cd] %@", query)
            let summaryPredicate = NSPredicate(format: "summaryContent CONTAINS[cd] %@", query)

            predicates.append(NSCompoundPredicate(orPredicateWithSubpredicates: [
                titlePredicate,
                contentPredicate,
                summaryPredicate
            ]))
        }

        if let filterTag = filterTag {
            predicates.append(NSPredicate(format: "ANY tags.id == %@", filterTag.id as CVarArg))
        }

        if !predicates.isEmpty {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }

        request.sortDescriptors = [NSSortDescriptor(keyPath: \Note.createdAt, ascending: false)]

        do {
            searchResults = try context.fetch(request)
        } catch {
            print("Search error: \(error)")
            searchResults = []
        }

        isSearching = false
    }

    func clearSearch() {
        searchResults = []
        selectedTag = nil
        isSearching = false
    }
}
