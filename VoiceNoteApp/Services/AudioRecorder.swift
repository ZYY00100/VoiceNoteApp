//
//  AudioRecorder.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import Foundation
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    private var audioSession: AVAudioSession = AVAudioSession.sharedInstance()

    @Published var isRecording = false
    @Published var recordingDuration: TimeInterval = 0
    @Published var recordingURL: URL?
    @Published var errorMessage: String?

    private var timer: Timer?

    override init() {
        super.init()
        setupAudioSession()
    }

    private func setupAudioSession() {
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            errorMessage = "音频会话初始化失败：\(error.localizedDescription)"
            print("Failed to setup audio session: \(error)")
        }
    }

    func requestPermission() async -> Bool {
        return await withCheckedContinuation { continuation in
            audioSession.requestRecordPermission { granted in
                continuation.resume(returning: granted)
            }
        }
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    func startRecording() {
        guard audioSession.isInputAvailable else {
            errorMessage = "没有可用的麦克风输入（模拟器通常不支持录音）。"
            print("No audio input available")
            return
        }
        let filename = "recording_\(UUID().uuidString).m4a"
        let url = getDocumentsDirectory().appendingPathComponent(filename)

        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.delegate = self
            let started = audioRecorder?.record() ?? false
            if !started {
                errorMessage = "录音启动失败，请检查麦克风权限或使用真机。"
                isRecording = false
                return
            }
            isRecording = true
            recordingURL = url
            recordingDuration = 0

            startTimer()
        } catch {
            errorMessage = "无法开始录音：\(error.localizedDescription)"
            print("Could not start recording: \(error)")
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        stopTimer()

        // Get final duration from the recorder
        if let recorder = audioRecorder {
            recordingDuration = recorder.currentTime
        }
    }

    func pauseRecording() {
        audioRecorder?.pause()
        isRecording = false
        stopTimer()
    }

    func resumeRecording() {
        audioRecorder?.record()
        isRecording = true
        startTimer()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.recordingDuration = self?.audioRecorder?.currentTime ?? 0
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func getRecordingURL() -> URL? {
        return recordingURL
    }

    func isInputAvailable() -> Bool {
        audioSession.isInputAvailable
    }

    func deleteRecording(at url: URL) {
        try? FileManager.default.removeItem(at: url)
    }
}

extension AudioRecorder: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Recording finished successfully")
        } else {
            print("Recording failed")
        }
    }
}
