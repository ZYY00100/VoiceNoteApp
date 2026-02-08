//
//  TagManagementView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import SwiftUI
import CoreData

struct TagManagementView: View {
    let repository: NoteRepository
    let viewContext: NSManagedObjectContext
    @StateObject private var viewModel: TagManagementViewModel

    init(repository: NoteRepository, viewContext: NSManagedObjectContext) {
        self.repository = repository
        self.viewContext = viewContext
        _viewModel = StateObject(wrappedValue: TagManagementViewModel(context: viewContext, repository: repository))
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.tags.isEmpty {
                    GlassCardView {
                        emptyTagsView
                    }
                    .padding()
                } else {
                    tagsListView(viewModel: viewModel)
                }
            }
            .navigationTitle("标签管理")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showingAddTag = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: Binding(
                get: { viewModel.showingAddTag },
                set: { viewModel.showingAddTag = $0 }
            )) {
                AddTagSheet(viewModel: viewModel)
            }
        }
        .appScreenStyle()
    }

    private var emptyTagsView: some View {
        VStack(spacing: 20) {
            Image(systemName: "tag")
                .font(.system(size: 60))
                .foregroundColor(.gray)

            Text("还没有标签")
                .font(.title2)
                .foregroundColor(.gray)

            Text("创建标签来组织你的笔记")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
    }

    private func tagsListView(viewModel: TagManagementViewModel) -> some View {
        GlassCardView {
            List {
                ForEach(viewModel.tags) { tag in
                    TagRowView(tag: tag, viewModel: viewModel)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewModel.deleteTag(viewModel.tags[index])
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
        }
        .padding(.horizontal)
    }
}

struct AddTagSheet: View {
    @ObservedObject var viewModel: TagManagementViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("标签名称")) {
                    TextField("输入标签名称", text: $viewModel.newTagName)
                }

                Section(header: Text("选择颜色")) {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        ForEach(viewModel.availableColors, id: \.self) { color in
                            Button(action: {
                                viewModel.selectedColor = color
                            }) {
                                Circle()
                                    .fill(Color(color))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 2)
                                            .overlay(
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.white)
                                                    .font(.caption)
                                            )
                                            .opacity(viewModel.selectedColor == color ? 1 : 0)
                                    )
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("新建标签")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("添加") {
                        viewModel.createTag()
                        dismiss()
                    }
                    .disabled(viewModel.newTagName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

struct TagRowView: View {
    let tag: Tag
    let viewModel: TagManagementViewModel

    var body: some View {
        HStack {
            Circle()
                .fill(Color(tag.color))
                .frame(width: 16, height: 16)

            Text(tag.name)
                .font(.body)

            Spacer()

            // Note count
            let noteCount = tag.notesArray.count
            if noteCount > 0 {
                Text("\(noteCount) 条笔记")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    let context = PersistenceController(inMemory: true).container.viewContext
    let repo = NoteRepository(context: context)
    return TagManagementView(repository: repo, viewContext: context)
}
