//
//  NoteCardView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import SwiftUI

struct NoteCardView: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header: Title and Date
            HStack {
                Text(note.title)
                    .font(.headline)
                    .lineLimit(1)

                Spacer()

                Text(formattedDate(note.createdAt))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            // Summary preview
            if !note.summaryContent.isEmpty {
                Text(note.summaryContent)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(2)
            }

            // Tags
            if !note.tagsArray.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(note.tagsArray) { tag in
                            TagChipView(tag: tag, size: .small)
                        }
                    }
                }
            }

            // Footer: Duration and Todo indicator
            HStack {
                if note.duration > 0 {
                    Label(durationString(note.duration), systemImage: "clock")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                if note.isTodo {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.string(from: date)
    }

    private func durationString(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

#Preview {
    let note: Note = {
        let context = PersistenceController(inMemory: true).container.viewContext
        let note = Note(context: context)
        note.id = UUID()
        note.title = "示例笔记"
        note.summaryContent = "这是一个示例总结内容，用于展示笔记卡片的外观。"
        note.createdAt = Date()
        note.duration = 120
        return note
    }()

    VStack {
        NoteCardView(note: note)
            .padding()
    }
}
