//
//  Note.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var originalContent: String
    @NSManaged public var summaryContent: String
    @NSManaged public var audioURL: String?
    @NSManaged public var createdAt: Date
    @NSManaged public var duration: Double
    @NSManaged public var isTodo: Bool
    @NSManaged public var tags: NSSet?
}

extension Note {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    var tagsArray: [Tag] {
        let set = tags as? Set<Tag> ?? []
        return set.sorted { $0.name < $1.name }
    }
}

extension Note : Identifiable {
}
