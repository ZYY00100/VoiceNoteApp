//
//  NoteListView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import SwiftUI

struct NoteListView: View {
    let repository: NoteRepository
    @StateObject private var viewModel: NoteListViewModel
    @State private var selectedNote: Note?
    @State private var showingRecording = false

    init(repository: NoteRepository) {
        self.repository = repository
        _viewModel = StateObject(wrappedValue: NoteListViewModel(repository: repository))
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.notes.isEmpty {
                    GlassCardView {
                        emptyView
                    }
                    .padding()
                } else {
                    notesList(viewModel: viewModel)
                }
            }
            .navigationTitle("笔记")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingRecording = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingRecording) {
                RecordingView(repository: repository)
            }
        }
        .appScreenStyle()
    }

    private var emptyView: some View {
        VStack(spacing: 20) {
            AppLogoView(size: 88)

            Image(systemName: "note.text")
                .font(.system(size: 60))
                .foregroundColor(.gray)

            Text("还没有笔记")
                .font(.title2)
                .foregroundColor(.gray)

            Text("点击 + 开始录制语音笔记")
                .font(.body)
                .foregroundColor(.secondary)

            Button("开始录音") {
                showingRecording = true
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }

    private func notesList(viewModel: NoteListViewModel) -> some View {
        VStack(spacing: 12) {
            GlassCardView {
                HStack(spacing: 12) {
                    AppLogoView(size: 44)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("VoiceNote")
                            .font(.headline)
                        Text("你的语音笔记与总结")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)

            List {
                ForEach(viewModel.notes) { note in
                    NoteCardView(note: note)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedNote = note
                        }
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.deleteNote(note)
                            } label: {
                                Label("删除", systemImage: "trash")
                            }
                        }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .refreshable {
                viewModel.loadNotes()
            }
            .sheet(item: $selectedNote) { note in
                NoteDetailView(note: note, repository: repository)
            }
        }
    }
}

#Preview {
    let context = PersistenceController(inMemory: true).container.viewContext
    let repo = NoteRepository(context: context)
    return NoteListView(repository: repo)
}
