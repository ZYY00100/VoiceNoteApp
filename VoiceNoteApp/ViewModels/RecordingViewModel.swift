//
//  RecordingViewModel.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import Combine
import Speech

class RecordingViewModel: ObservableObject {
    @Published var isRecording = false
    @Published var recordingDuration: TimeInterval = 0
    @Published var isPaused = false
    @Published var errorMessage: String?
    @Published var processingState: ProcessingState = .idle
    @Published var micPermissionGranted: Bool?
    @Published var speechAuthorizationStatus: SFSpeechRecognizerAuthorizationStatus?

    private let audioRecorder = AudioRecorder()
    private let speechRecognizer = SpeechRecognizer()
    private let noteProcessor = NoteProcessor()
    private let repository: NoteRepository
    private var currentRecordingURL: URL?

    private var cancellables = Set<AnyCancellable>()

    enum ProcessingState {
        case idle
        case recording
        case transcribing
        case summarizing
        case saving
        case completed
    }

    init(repository: NoteRepository) {
        self.repository = repository
        setupBindings()
    }

    private func setupBindings() {
        audioRecorder.$isRecording
            .receive(on: DispatchQueue.main)
            .assign(to: &$isRecording)

        audioRecorder.$recordingDuration
            .receive(on: DispatchQueue.main)
            .assign(to: &$recordingDuration)

        audioRecorder.$errorMessage
            .receive(on: DispatchQueue.main)
            .assign(to: &$errorMessage)
    }

    func requestPermissions() async -> Bool {
        let hasMicPermission = await audioRecorder.requestPermission()
        let speechStatus = await speechRecognizer.requestAuthorization()

        await MainActor.run {
            micPermissionGranted = hasMicPermission
            speechAuthorizationStatus = speechStatus
        }

        return hasMicPermission && speechStatus == .authorized
    }

    func startRecording() {
        guard audioRecorder.isInputAvailable() else {
            errorMessage = "当前设备没有可用的麦克风输入，模拟器可能不支持录音。"
            return
        }
        currentRecordingURL = nil
        audioRecorder.startRecording()
        isPaused = false
        processingState = .recording
    }

    func stopRecording() async {
        audioRecorder.stopRecording()
        isPaused = false
        currentRecordingURL = audioRecorder.getRecordingURL()

        if let url = currentRecordingURL {
            await processRecording(url: url)
        }
    }

    func pauseRecording() {
        audioRecorder.pauseRecording()
        isPaused = true
    }

    func resumeRecording() {
        audioRecorder.resumeRecording()
        isPaused = false
    }

    func cancelRecording() {
        audioRecorder.stopRecording()
        isPaused = false
        processingState = .idle

        if let url = currentRecordingURL {
            audioRecorder.deleteRecording(at: url)
        }
    }

    private func processRecording(url: URL) async {
        do {
            // Step 1: Transcribe audio
            processingState = .transcribing
            let transcription = try await speechRecognizer.transcribeAudioFile(url: url)

            // Step 2: Generate summary
            processingState = .summarizing
            let result = try await noteProcessor.processNote(transcription)

            // Step 3: Save note
            processingState = .saving
            await MainActor.run {
                _ = repository.createNote(
                    title: result.title,
                    originalContent: result.originalContent,
                    summaryContent: result.summaryContent,
                    audioURL: url.path
                )
                processingState = .completed
            }

            // Reset after a short delay
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
            processingState = .idle

        } catch {
            await MainActor.run {
                errorMessage = "处理失败: \(error.localizedDescription)"
                processingState = .idle
            }
        }
    }

    var formattedDuration: String {
        let minutes = Int(recordingDuration) / 60
        let seconds = Int(recordingDuration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var inputAvailable: Bool {
        audioRecorder.isInputAvailable()
    }
}
