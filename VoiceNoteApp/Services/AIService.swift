//
//  AIService.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation

class AIService {
    private let apiKey: String
    private let endpoint = "https://dashscope.aliyuncs.com/api/v1/services/aigc/text-generation/generation"

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    struct SummaryRequest: Codable {
        let model: String
        let input: Input
        let parameters: Parameters

        struct Input: Codable {
            let messages: [Message]
        }

        struct Message: Codable {
            let role: String
            let content: String
        }

        struct Parameters: Codable {
            let temperature: Double
            let maxTokens: Int
        }
    }

    struct SummaryResponse: Codable {
        let output: Output?
        let code: String?
        let message: String?

        struct Output: Codable {
            let text: String?
            let choices: [Choice]?

            struct Choice: Codable {
                let message: Message?

                struct Message: Codable {
                    let content: String?
                }
            }
        }
    }

    func summarizeText(_ text: String) async throws -> String {
        guard !text.isEmpty else {
            return ""
        }

        let systemPrompt = """
        你是一个专业的笔记总结助手。请将用户提供的语音转文字内容进行总结，要求：
        1. 提取关键要点
        2. 保持精简但不丢失核心信息
        3. 使用清晰的排版（使用项目符号）
        4. 语言简洁明了，易于阅读
        """

        let request = SummaryRequest(
            model: "qwen-plus",
            input: SummaryRequest.Input(messages: [
                SummaryRequest.Message(role: "system", content: systemPrompt),
                SummaryRequest.Message(role: "user", content: text)
            ]),
            parameters: SummaryRequest.Parameters(
                temperature: 0.7,
                maxTokens: 500
            )
        )

        var urlRequest = URLRequest(url: URL(string: endpoint)!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(request)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw AIError.requestFailed
        }

        let summaryResponse = try JSONDecoder().decode(SummaryResponse.self, from: data)

        if let text = summaryResponse.output?.text {
            return text
        } else if let text = summaryResponse.output?.choices?.first?.message?.content {
            return text
        } else {
            throw AIError.noContent
        }
    }

    enum AIError: Error {
        case requestFailed
        case noContent
        case invalidResponse
    }
}

// Default configuration for development
extension AIService {
    static func createDefault() -> AIService {
        // In production, load from secure storage or config file
        let apiKey = Config.shared.qwenAPIKey
        return AIService(apiKey: apiKey)
    }
}

// Configuration file for API keys
struct Config {
    static let shared = Config()

    var qwenAPIKey: String {
        // Load API key from configuration
        return "sk-f3b9d9baebde4f8f86cf51dee7446430"
    }
}
