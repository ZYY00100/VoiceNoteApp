//
//  TagChipView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import SwiftUI

struct TagChipView: View {
    let tag: Tag
    var isSelected: Bool = false
    var size: ChipSize = .normal

    enum ChipSize {
        case normal
        case small

        var horizontalPadding: CGFloat {
            switch self {
            case .normal: return 12
            case .small: return 8
            }
        }

        var verticalPadding: CGFloat {
            switch self {
            case .normal: return 8
            case .small: return 4
            }
        }

        var font: Font {
            switch self {
            case .normal: return .body
            case .small: return .caption
            }
        }
    }

    var body: some View {
        Text(tag.name)
            .font(size.font)
            .padding(.horizontal, size.horizontalPadding)
            .padding(.vertical, size.verticalPadding)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(16)
    }

    private var backgroundColor: Color {
        if isSelected {
            return Color(tag.color)
        } else {
            return Color(tag.color).opacity(0.2)
        }
    }

    private var foregroundColor: Color {
        if isSelected {
            return .white
        } else {
            return Color(tag.color)
        }
    }
}

#Preview {
    let tags: (work: Tag, life: Tag, important: Tag, study: Tag) = {
        let context = PersistenceController(inMemory: true).container.viewContext

        let workTag = Tag(context: context)
        workTag.id = UUID()
        workTag.name = "工作"
        workTag.color = "blue"

        let lifeTag = Tag(context: context)
        lifeTag.id = UUID()
        lifeTag.name = "生活"
        lifeTag.color = "green"

        let importantTag = Tag(context: context)
        importantTag.id = UUID()
        importantTag.name = "重要"
        importantTag.color = "red"

        let studyTag = Tag(context: context)
        studyTag.id = UUID()
        studyTag.name = "学习"
        studyTag.color = "purple"

        return (workTag, lifeTag, importantTag, studyTag)
    }()

    VStack(spacing: 10) {
        HStack(spacing: 10) {
            TagChipView(tag: tags.work)
            TagChipView(tag: tags.life, isSelected: true)
            TagChipView(tag: tags.important)
        }

        HStack(spacing: 10) {
            TagChipView(tag: tags.work, size: .small)
            TagChipView(tag: tags.study, isSelected: true, size: .small)
        }
    }
    .padding()
}
