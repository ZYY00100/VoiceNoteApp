//
//  NoteListViewModel.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import Combine

class NoteListViewModel: ObservableObject {
    @Published var notes: [Note] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository: NoteRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: NoteRepository) {
        self.repository = repository
        setupBindings()
    }

    private func setupBindings() {
        repository.$notes
            .receive(on: DispatchQueue.main)
            .assign(to: &$notes)
    }

    func loadNotes() {
        isLoading = true
        repository.fetchNotes()
        isLoading = false
    }

    func deleteNote(_ note: Note) {
        repository.deleteNote(note)
    }

    func toggleTodo(_ note: Note) {
        repository.updateNote(note, isTodo: !note.isTodo)
    }
}
