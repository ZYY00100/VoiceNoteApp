#!/usr/bin/env python3

import os
import subprocess

# 项目路径
PROJECT_NAME = "VoiceNoteApp"
PROJECT_PATH = "/Users/a1-6/claude-code/002/" + PROJECT_NAME

# 所有 Swift 文件列表
SWIFT_FILES = [
    "VoiceNoteApp.swift",
    "ContentView.swift",
    "Persistence.swift",
    "Models/Note.swift",
    "Models/Tag.swift",
    "ViewModels/NoteListViewModel.swift",
    "ViewModels/RecordingViewModel.swift",
    "ViewModels/NoteDetailViewModel.swift",
    "ViewModels/SearchViewModel.swift",
    "ViewModels/TagManagementViewModel.swift",
    "Views/NoteListView.swift",
    "Views/NoteDetailView.swift",
    "Views/RecordingView.swift",
    "Views/SearchView.swift",
    "Views/TagManagementView.swift",
    "Views/Components/NoteCardView.swift",
    "Views/Components/AudioRecorderView.swift",
    "Views/Components/TagChipView.swift",
    "Services/AudioRecorder.swift",
    "Services/SpeechRecognizer.swift",
    "Services/AIService.swift",
    "Services/TranscriptionService.swift",
    "Services/NoteProcessor.swift",
    "Services/NoteRepository.swift",
    "Services/SearchService.swift",
    "Services/ShareService.swift",
]

print("请使用以下步骤添加文件:")
print("")
print("1. 关闭 Xcode")
print("2. 运行: open /Users/a1-6/claude-code/002/VoiceNoteApp")
print("3. 在 Xcode 中: File → Add Files to 'VoiceNoteApp'")
print("4. 按住 Cmd 键，逐个选择以下文件:")
for f in SWIFT_FILES:
    print(f"   - {f}")

