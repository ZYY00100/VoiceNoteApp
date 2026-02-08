//
//  SpeechRecognizer.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import Speech

class SpeechRecognizer: NSObject, ObservableObject {
    private let recognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    @Published var transcription = ""
    @Published var isRecognizing = false

    override init() {
        recognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh-CN"))
        super.init()
    }

    func requestAuthorization() async -> SFSpeechRecognizerAuthorizationStatus {
        return await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status)
            }
        }
    }

    func transcribeAudioFile(url: URL) async throws -> String {
        let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh-CN"))
        guard let recognizer = recognizer, recognizer.isAvailable else {
            throw SpeechRecognitionError.notAvailable
        }

        let request = SFSpeechURLRecognitionRequest(url: url)
        request.shouldReportPartialResults = false

        return try await withCheckedThrowingContinuation { continuation in
            recognizer.recognitionTask(with: request) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                if let result = result, result.isFinal {
                    continuation.resume(returning: result.bestTranscription.formattedString)
                }
            }
        }
    }

    enum SpeechRecognitionError: Error {
        case notAvailable
        case notAuthorized
        case noAudioEngine
    }
}
