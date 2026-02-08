//
//  Tag.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import CoreData

@objc(Tag)
public class Tag: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var color: String
    @NSManaged public var notes: NSSet?
}

extension Tag {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    var notesArray: [Note] {
        let set = notes as? Set<Note> ?? []
        return set.sorted { $0.createdAt < $1.createdAt }
    }
}

extension Tag : Identifiable {
}
