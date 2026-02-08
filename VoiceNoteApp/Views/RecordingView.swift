//
//  RecordingView.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import SwiftUI
import AVFoundation
import UIKit
import Speech

struct RecordingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: RecordingViewModel
    @State private var showingPermissionAlert = false

    init(repository: NoteRepository) {
        _viewModel = StateObject(wrappedValue: RecordingViewModel(repository: repository))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Spacer()

                // Recording Status
                GlassCardView {
                    recordingStatusView(viewModel: viewModel)
                }
                .padding(.horizontal)

                Spacer()

                // Recording Controls
                GlassCardView {
                    recordingControls(viewModel: viewModel)
                }
                .padding(.horizontal)

                // Diagnostics
                GlassCardView {
                    diagnosticsView(viewModel: viewModel)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("录音")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if viewModel.isRecording {
                        Button("取消") {
                            viewModel.cancelRecording()
                            dismiss()
                        }
                    } else {
                        Button("关闭") {
                            dismiss()
                        }
                    }
                }
            }
            .alert("需要麦克风权限", isPresented: $showingPermissionAlert) {
                Button("取消", role: .cancel) {
                    dismiss()
                }
                Button("设置") {
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsUrl)
                    }
                }
            } message: {
                Text("请在设置中允许访问麦克风以使用录音功能")
            }
            .alert("录音不可用", isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )) {
                Button("确定", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "未知错误")
            }
        }
        .appScreenStyle()
        .onAppear {
            requestPermissions()
        }
    }

    private func recordingStatusView(viewModel: RecordingViewModel) -> some View {
        VStack(spacing: 20) {
            // Recording Indicator
            ZStack {
                Circle()
                    .fill(viewModel.isRecording ? Color.red.opacity(0.2) : Color.gray.opacity(0.1))
                    .frame(width: 200, height: 200)

                Circle()
                    .fill(viewModel.isRecording ? Color.red : Color.gray)
                    .frame(width: 20, height: 20)
                    .scaleEffect(viewModel.isRecording ? 1.0 : 0.5)
                    .animation(
                        viewModel.isRecording ?
                            Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true) :
                            .default,
                        value: viewModel.isRecording
                    )
            }

            // Duration
            Text(viewModel.formattedDuration)
                .font(.system(size: 48, weight: .light, design: .monospaced))
                .foregroundColor(.primary)

            // Status Message
            statusMessage(viewModel: viewModel)
        }
    }

    @ViewBuilder
    private func statusMessage(viewModel: RecordingViewModel) -> some View {
        Group {
            switch viewModel.processingState {
            case .idle:
                Text("点击下方按钮开始录音")
                    .foregroundColor(.secondary)
            case .recording:
                Text(viewModel.isPaused ? "已暂停" : "录音中...")
                    .foregroundColor(.red)
            case .transcribing:
                VStack(spacing: 8) {
                    ProgressView()
                    Text("正在转录语音...")
                        .foregroundColor(.secondary)
                }
            case .summarizing:
                VStack(spacing: 8) {
                    ProgressView()
                    Text("正在生成总结...")
                        .foregroundColor(.secondary)
                }
            case .saving:
                VStack(spacing: 8) {
                    ProgressView()
                    Text("正在保存笔记...")
                        .foregroundColor(.secondary)
                }
            case .completed:
                Text("录音完成！")
                    .foregroundColor(.green)
            }
        }
    }

    private func recordingControls(viewModel: RecordingViewModel) -> some View {
        HStack(spacing: 40) {
            // Cancel Button (when recording)
            if viewModel.isRecording {
                Button(action: {
                    viewModel.cancelRecording()
                    dismiss()
                }) {
                    VStack(spacing: 8) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.red)
                        Text("取消")
                            .font(.caption)
                    }
                }
            }

            // Main Recording Button
            Button(action: {
                if viewModel.isRecording {
                    Task {
                        await viewModel.stopRecording()
                    }
                } else {
                    viewModel.startRecording()
                }
            }) {
                ZStack {
                    Circle()
                        .fill(viewModel.isRecording ? Color.red : Color.red)
                        .frame(width: 80, height: 80)

                    if viewModel.isRecording {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 30, height: 30)
                            .cornerRadius(4)
                    } else {
                        Circle()
                            .fill(.white)
                            .frame(width: 30, height: 30)
                    }
                }
            }
            .disabled(viewModel.processingState != .idle && viewModel.processingState != .recording)

            // Pause/Resume Button (when recording)
            if viewModel.isRecording {
                Button(action: {
                    if viewModel.isPaused {
                        viewModel.resumeRecording()
                    } else {
                        viewModel.pauseRecording()
                    }
                }) {
                    VStack(spacing: 8) {
                        Image(systemName: viewModel.isPaused ? "play.circle.fill" : "pause.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                        Text(viewModel.isPaused ? "继续" : "暂停")
                            .font(.caption)
                    }
                }
            }
        }
    }

    private func diagnosticsView(viewModel: RecordingViewModel) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("权限与硬件")
                    .font(.headline)
                Spacer()
                Button("刷新") {
                    requestPermissions()
                }
                .font(.subheadline)
            }

            statusRow(
                title: "麦克风权限",
                status: permissionText(viewModel.micPermissionGranted)
            )
            statusRow(
                title: "语音识别权限",
                status: speechAuthText(viewModel.speechAuthorizationStatus)
            )
            statusRow(
                title: "硬件输入",
                status: viewModel.inputAvailable ? "可用" : "不可用"
            )

            if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundColor(.red)
            }
        }
    }

    private func statusRow(title: String, status: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(status)
                .fontWeight(.semibold)
        }
        .font(.subheadline)
    }

    private func permissionText(_ granted: Bool?) -> String {
        guard let granted = granted else { return "未请求" }
        return granted ? "已允许" : "未允许"
    }

    private func speechAuthText(_ status: SFSpeechRecognizerAuthorizationStatus?) -> String {
        guard let status = status else { return "未请求" }
        switch status {
        case .authorized: return "已允许"
        case .denied: return "已拒绝"
        case .restricted: return "受限制"
        case .notDetermined: return "未请求"
        @unknown default: return "未知"
        }
    }

    private func requestPermissions() {
        Task {
            let hasPermission = await viewModel.requestPermissions()
            if !hasPermission {
                await MainActor.run {
                    showingPermissionAlert = true
                }
            }
        }
    }
}

#Preview {
    let context = PersistenceController(inMemory: true).container.viewContext
    let repo = NoteRepository(context: context)
    return RecordingView(repository: repo)
}
