//
//  NoteProcessor.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation

class NoteProcessor {
    private let aiService: AIService

    init(aiService: AIService = .createDefault()) {
        self.aiService = aiService
    }

    func processNote(_ originalText: String) async throws -> NoteProcessResult {
        let summary = try await aiService.summarizeText(originalText)
        let title = generateTitle(from: originalText)

        return NoteProcessResult(
            title: title,
            originalContent: originalText,
            summaryContent: summary
        )
    }

    private func generateTitle(from text: String) -> String {
        // Take first sentence or first 30 characters as title
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)

        if let firstSentenceRange = trimmedText.range(of: "。|？|！|；", options: .regularExpression) {
            return String(trimmedText[..<firstSentenceRange.upperBound])
        }

        if trimmedText.count > 30 {
            let index = trimmedText.index(trimmedText.startIndex, offsetBy: 30)
            return String(trimmedText[..<index]) + "..."
        }

        return trimmedText.isEmpty ? "新建笔记" : trimmedText
    }

    struct NoteProcessResult {
        let title: String
        let originalContent: String
        let summaryContent: String
    }
}
