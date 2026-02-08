//
//  AudioRecorderView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import SwiftUI
import AVFoundation

struct AudioRecorderView: View {
    @StateObject private var audioRecorder = AudioRecorder()
    @State private var isRecording = false
    @State private var isPlaying = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var audioPlayerDelegate: AudioPlayerDelegate?

    var body: some View {
        VStack(spacing: 20) {
            // Waveform visualization (placeholder)
            waveformView

            // Duration display
            Text(formattedDuration(audioRecorder.recordingDuration))
                .font(.system(size: 36, weight: .light, design: .monospaced))
                .foregroundColor(.primary)

            // Control buttons
            controlButtons
        }
        .padding()
        .onAppear {
            setupAudioSession()
        }
    }

    private var waveformView: some View {
        HStack(alignment: .center, spacing: 2) {
            ForEach(0..<30, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(isRecording ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 4, height: CGFloat.random(in: 20...60))
                    .animation(isRecording ?
                        Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(Double(index) * 0.05) :
                        .default,
                        value: isRecording
                    )
            }
        }
        .frame(height: 80)
    }

    private var controlButtons: some View {
        HStack(spacing: 40) {
            // Stop/Delete button
            Button(action: {
                if let url = audioRecorder.getRecordingURL() {
                    audioRecorder.deleteRecording(at: url)
                }
                audioRecorder.stopRecording()
                isRecording = false
            }) {
                Image(systemName: "stop.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.red)
            }
            .disabled(!isRecording)

            // Record button
            Button(action: {
                if isRecording {
                    audioRecorder.stopRecording()
                    isRecording = false
                } else {
                    audioRecorder.startRecording()
                    isRecording = true
                }
            }) {
                ZStack {
                    Circle()
                        .fill(isRecording ? Color.red : Color.blue)
                        .frame(width: 80, height: 80)

                    if isRecording {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 30, height: 30)
                            .cornerRadius(4)
                    } else {
                        Image(systemName: "mic.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                }
            }

            // Play button (after recording)
            if !isRecording, let url = audioRecorder.getRecordingURL() {
                Button(action: {
                    playRecording(at: url)
                }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                }
            } else {
                Spacer()
                    .frame(width: 50)
            }
        }
    }

    private func playRecording(at url: URL) {
        do {
            if isPlaying {
                audioPlayer?.stop()
                isPlaying = false
            } else {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayerDelegate = AudioPlayerDelegate { finished in
                    if finished {
                        isPlaying = false
                    }
                }
                audioPlayer?.delegate = audioPlayerDelegate
                audioPlayer?.play()
                isPlaying = true
            }
        } catch {
            print("Error playing audio: \(error)")
        }
    }

    private func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }

    private func formattedDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

class AudioPlayerDelegate: NSObject, AVAudioPlayerDelegate {
    let didFinishPlaying: (Bool) -> Void

    init(didFinishPlaying: @escaping (Bool) -> Void) {
        self.didFinishPlaying = didFinishPlaying
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        didFinishPlaying(flag)
    }
}

#Preview {
    AudioRecorderView()
}
