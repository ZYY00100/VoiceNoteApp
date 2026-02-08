//
//  SearchView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import SwiftUI
import CoreData

struct SearchView: View {
    let repository: NoteRepository
    let viewContext: NSManagedObjectContext
    @StateObject private var viewModel: SearchViewModel
    @State private var selectedNote: Note?

    init(repository: NoteRepository, viewContext: NSManagedObjectContext) {
        self.repository = repository
        self.viewContext = viewContext
        let service = SearchService(context: viewContext)
        _viewModel = StateObject(wrappedValue: SearchViewModel(searchService: service, repository: repository))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                GlassCardView {
                    VStack(spacing: 12) {
                        // Search Bar
                        searchHeaderView

                        // Tag Filter
                        tagFilterView(viewModel: viewModel)
                    }
                }
                .padding(.horizontal)

                // Search Results
                searchResultsView(viewModel: viewModel)
            }
            .navigationTitle("搜索")
        }
        .appScreenStyle()
        .onAppear {
            viewModel.searchResults = repository.notes
        }
    }

    private var searchHeaderView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)

            TextField(
                "搜索笔记...",
                text: Binding(
                    get: { viewModel.searchQuery },
                    set: { viewModel.searchQuery = $0 }
                )
            )
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }

    private func tagFilterView(viewModel: SearchViewModel) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                // "All" tag
                Button(action: {
                    viewModel.selectedTag = nil
                }) {
                    Text("全部")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(viewModel.selectedTag == nil ? Color.blue : Color(.systemGray6))
                        .foregroundColor(viewModel.selectedTag == nil ? .white : .primary)
                        .cornerRadius(20)
                }

                // Tag chips
                ForEach(repository.tags) { tag in
                    Button(action: {
                        viewModel.selectedTag = viewModel.selectedTag?.id == tag.id ? nil : tag
                    }) {
                        TagChipView(tag: tag, isSelected: viewModel.selectedTag?.id == tag.id)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private func searchResultsView(viewModel: SearchViewModel) -> some View {
        Group {
            if viewModel.isSearching {
                ProgressView("搜索中...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.searchResults.isEmpty {
                GlassCardView {
                    emptyView
                }
                .padding()
            } else {
                List {
                    ForEach(viewModel.searchResults) { note in
                        NoteCardView(note: note)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedNote = note
                            }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .sheet(item: $selectedNote) { note in
            NoteDetailView(note: note, repository: repository)
        }
    }

    private var emptyView: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)

            Text("没有找到匹配的笔记")
                .font(.title2)
                .foregroundColor(.gray)

            Text("尝试使用不同的关键词搜索")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

extension NoteRepository {
    var tags: [Tag] {
        let request: NSFetchRequest<Tag> = Tag.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Tag.name, ascending: true)]

        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
}

#Preview {
    let context = PersistenceController(inMemory: true).container.viewContext
    let repo = NoteRepository(context: context)
    return SearchView(repository: repo, viewContext: context)
}
