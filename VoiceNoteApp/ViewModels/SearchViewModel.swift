//
//  SearchViewModel.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import CoreData
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var searchResults: [Note] = []
    @Published var isSearching = false
    @Published var selectedTag: Tag?

    private let searchService: SearchService
    private let repository: NoteRepository
    private var cancellables = Set<AnyCancellable>()

    init(searchService: SearchService, repository: NoteRepository) {
        self.searchService = searchService
        self.repository = repository

        setupBindings()
    }

    private func setupBindings() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .combineLatest($selectedTag)
            .sink { [weak self] (query, tag) in
                self?.performSearch(query: query, tag: tag)
            }
            .store(in: &cancellables)

        searchService.$searchResults
            .receive(on: DispatchQueue.main)
            .assign(to: &$searchResults)

        searchService.$isSearching
            .receive(on: DispatchQueue.main)
            .assign(to: &$isSearching)
    }

    private func performSearch(query: String, tag: Tag?) {
        if query.isEmpty && tag == nil {
            searchResults = repository.notes
        } else {
            searchService.search(query: query, filterTag: tag)
        }
    }

    func clearSearch() {
        searchQuery = ""
        selectedTag = nil
        searchResults = repository.notes
    }
}
