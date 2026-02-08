//
//  NoteDetailViewModel.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import SwiftUI

class NoteDetailViewModel: ObservableObject {
    @Published var note: Note
    @Published var isEditing = false
    @Published var title: String
    @Published var originalContent: String
    @Published var summaryContent: String
    @Published var isSaving = false
    @Published var errorMessage: String?

    private let repository: NoteRepository

    init(note: Note, repository: NoteRepository) {
        self.note = note
        self.repository = repository
        self.title = note.title
        self.originalContent = note.originalContent
        self.summaryContent = note.summaryContent
    }

    func saveChanges() {
        isSaving = true

        repository.updateNote(
            note,
            title: title,
            originalContent: originalContent,
            summaryContent: summaryContent
        )

        isSaving = false
        isEditing = false
    }

    func cancelEditing() {
        title = note.title
        originalContent = note.originalContent
        summaryContent = note.summaryContent
        isEditing = false
    }

    func deleteNote() {
        repository.deleteNote(note)
    }

    func regenerateSummary() async {
        do {
            let noteProcessor = NoteProcessor()
            let result = try await noteProcessor.processNote(originalContent)

            await MainActor.run {
                self.summaryContent = result.summaryContent
                self.title = result.title
                saveChanges()
            }
        } catch {
            errorMessage = "重新生成总结失败: \(error.localizedDescription)"
        }
    }
}
