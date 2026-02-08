//
//  NoteDetailView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import SwiftUI

struct NoteDetailView: View {
    let note: Note
    let repository: NoteRepository
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: NoteDetailViewModel
    @State private var showingDeleteAlert = false

    init(note: Note, repository: NoteRepository) {
        self.note = note
        self.repository = repository
        _viewModel = StateObject(wrappedValue: NoteDetailViewModel(note: note, repository: repository))
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isEditing {
                    editView(viewModel: viewModel)
                } else {
                    displayView(viewModel: viewModel)
                }
            }
            .navigationTitle("笔记详情")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("关闭") {
                        dismiss()
                    }
                }

                if !viewModel.isEditing {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button {
                                viewModel.isEditing = true
                            } label: {
                                Label("编辑", systemImage: "pencil")
                            }

                            Button {
                                Task {
                                    await viewModel.regenerateSummary()
                                }
                            } label: {
                                Label("重新生成总结", systemImage: "arrow.triangle.2.circlepath")
                            }

                            Button(role: .destructive) {
                                showingDeleteAlert = true
                            } label: {
                                Label("删除", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                }
            }
            .alert("删除笔记", isPresented: $showingDeleteAlert) {
                Button("取消", role: .cancel) {}
                Button("删除", role: .destructive) {
                    viewModel.deleteNote()
                    dismiss()
                }
            } message: {
                Text("确定要删除这条笔记吗？此操作无法撤销。")
            }
        }
        .appScreenStyle()
    }

    private func displayView(viewModel: NoteDetailViewModel) -> some View {
        ScrollView {
            GlassCardView {
                VStack(alignment: .leading, spacing: 20) {
                // Title
                Text(viewModel.note.title)
                    .font(.title)
                    .fontWeight(.bold)

                // Tags
                if !viewModel.note.tagsArray.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(viewModel.note.tagsArray) { tag in
                                TagChipView(tag: tag)
                            }
                        }
                    }
                }

                // Metadata
                HStack {
                    Label(DateFormatter.noteDate.string(from: viewModel.note.createdAt), systemImage: "calendar")
                    Spacer()
                    Label(durationString(viewModel.note.duration), systemImage: "clock")
                }
                .font(.caption)
                .foregroundColor(.secondary)

                Divider()

                // Summary
                if !viewModel.note.summaryContent.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("总结")
                            .font(.headline)
                            .foregroundColor(.secondary)

                        Text(viewModel.note.summaryContent)
                            .font(.body)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)

                    Divider()
                }

                // Original Content
                VStack(alignment: .leading, spacing: 10) {
                    Text("完整内容")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    Text(viewModel.note.originalContent)
                        .font(.body)
                }

                    Spacer()
                }
            }
            .padding(.horizontal)
        }
    }

    private func editView(viewModel: NoteDetailViewModel) -> some View {
        Form {
            Section(header: Text("标题")) {
                TextField(
                    "输入标题",
                    text: Binding(
                        get: { viewModel.title },
                        set: { viewModel.title = $0 }
                    )
                )
            }

            Section(header: Text("总结")) {
                TextEditor(
                    text: Binding(
                        get: { viewModel.summaryContent },
                        set: { viewModel.summaryContent = $0 }
                    )
                )
                    .frame(minHeight: 100)
            }

            Section(header: Text("完整内容")) {
                TextEditor(
                    text: Binding(
                        get: { viewModel.originalContent },
                        set: { viewModel.originalContent = $0 }
                    )
                )
                    .frame(minHeight: 200)
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("取消") {
                    viewModel.cancelEditing()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("保存") {
                    viewModel.saveChanges()
                }
                .disabled(viewModel.isSaving)
            }
        }
    }

    private func durationString(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

extension DateFormatter {
    static let noteDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter
    }()
}

#Preview {
    let context = PersistenceController(inMemory: true).container.viewContext
    let previewNote: Note = {
        let note = Note(context: context)
        note.id = UUID()
        note.title = "示例笔记"
        note.originalContent = "这是示例内容"
        note.summaryContent = "这是示例总结"
        note.createdAt = Date()
        note.duration = 90
        return note
    }()

    let repo = NoteRepository(context: context)
    return NoteDetailView(note: previewNote, repository: repo)
}
