//
//  TranscriptionService.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import Combine
import Network

class TranscriptionService: ObservableObject {
    private let speechRecognizer = SpeechRecognizer()
    private var cancellables = Set<AnyCancellable>()
    private let networkMonitor = NWPathMonitor()
    private let networkQueue = DispatchQueue(label: "NetworkMonitor")

    @Published var isProcessing = false
    @Published var queueCount = 0

    private var transcriptionQueue: [(noteId: UUID, audioURL: URL)] = []

    init() {
        startNetworkMonitoring()
    }

    private func startNetworkMonitoring() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.processQueue()
            }
        }
        networkQueue.async {
            self.networkMonitor.start(queue: self.networkQueue)
        }
    }

    func addToQueue(noteId: UUID, audioURL: URL) {
        transcriptionQueue.append((noteId: noteId, audioURL: audioURL))
        queueCount = transcriptionQueue.count
        processQueue()
    }

    private func processQueue() {
        guard !isProcessing, !transcriptionQueue.isEmpty else { return }

        isProcessing = true

        let item = transcriptionQueue.removeFirst()
        queueCount = transcriptionQueue.count

        Task {
            do {
                let text = try await speechRecognizer.transcribeAudioFile(url: item.audioURL)
                await MainActor.run {
                    // Notify about completion - would need to pass callback or use notification
                    print("Transcription completed for note \(item.noteId)")
                    isProcessing = false
                    processQueue()
                }
            } catch {
                print("Transcription failed: \(error)")
                await MainActor.run {
                    isProcessing = false
                    // Optionally re-add to queue for retry
                    transcriptionQueue.insert(item, at: 0)
                    queueCount = transcriptionQueue.count
                }
            }
        }
    }

    func transcribeNow(audioURL: URL) async throws -> String {
        return try await speechRecognizer.transcribeAudioFile(url: audioURL)
    }
}
