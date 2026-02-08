# VoiceNoteApp - Setup Guide

## Project Status

The VoiceNoteApp iOS MVP has been fully implemented with all planned features. Here's what has been created:

### Files Created

#### Core Application
- `VoiceNoteApp.swift` - App entry point
- `ContentView.swift` - Main tab view with navigation

#### Models (Data Layer)
- `Models/Note.swift` - Note entity with Core Data integration
- `Models/Tag.swift` - Tag entity with Core Data integration

#### ViewModels (MVVM Pattern)
- `ViewModels/NoteListViewModel.swift` - Note list management
- `ViewModels/RecordingViewModel.swift` - Recording and transcription logic
- `ViewModels/NoteDetailViewModel.swift` - Note detail editing
- `ViewModels/SearchViewModel.swift` - Search functionality
- `ViewModels/TagManagementViewModel.swift` - Tag CRUD operations

#### Views (UI Layer)
- `Views/NoteListView.swift` - Main notes list with cards
- `Views/RecordingView.swift` - Recording interface with controls
- `Views/NoteDetailView.swift` - Note detail and edit view
- `Views/SearchView.swift` - Search with tag filtering
- `Views/TagManagementView.swift` - Tag management interface

#### Components (Reusable UI)
- `Views/Components/AudioRecorderView.swift` - Audio recording component
- `Views/Components/NoteCardView.swift` - Note card display
- `Views/Components/TagChipView.swift` - Tag chip component

#### Services (Business Logic)
- `Services/AudioRecorder.swift` - AVFoundation-based recording
- `Services/SpeechRecognizer.swift` - Speech Framework integration
- `Services/TranscriptionService.swift` - Queued transcription processing
- `Services/AIService.swift` - Alibaba Cloud Qwen API integration
- `Services/NoteProcessor.swift` - Note processing and title generation
- `Services/NoteRepository.swift` - Core Data repository pattern
- `Services/SearchService.swift` - Search implementation
- `Services/ShareService.swift` - System share sheet integration

#### Persistence
- `Persistence/CoreDataStack.swift` - Core Data configuration
- `Persistence/VoiceNoteApp.xcdatamodeld` - Data model

#### Configuration
- `Info.plist` - App permissions and configuration
- `Resources/Assets.xcassets` - App icons and assets

## Opening in Xcode

Since creating a full .xcodeproj file manually is complex, you have two options:

### Option 1: Use Xcode (Recommended)

1. Open Xcode
2. Select "File > New > Project"
3. Choose "App" under iOS
4. Enter:
   - Product Name: `VoiceNoteApp`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Storage: `Core Data`
5. Save to a temporary location
6. Copy all the source files from this project into the Xcode project

### Option 2: Command Line Setup

```bash
# Navigate to the project directory
cd VoiceNoteApp

# Use Swift Package Manager to generate initial structure (for reference)
swift package init --type executable

# Then open in Xcode and add files manually
open -a Xcode .
```

## Adding Files to Xcode Project

Once you have a basic Xcode project:

1. **Delete default files**:
   - Delete `ContentView.swift` (use our version)
   - Keep `Persistence.swift` or rename our `CoreDataStack.swift`

2. **Add files by group**:
   - Right-click on project > Add Files to "VoiceNoteApp"
   - Select folders and check "Copy items if needed"
   - Add files in this order:
     1. `Models/`
     2. `ViewModels/`
     3. `Views/` (including `Components/`)
     4. `Services/`
     5. `Persistence/`

3. **Update Info.plist**:
   - Replace the default Info.plist with our version

4. **Update VoiceNoteApp.xcdatamodeld**:
   - Replace with our data model

## Configuration

### API Key Setup

Edit `Services/AIService.swift` and add your Alibaba Cloud Qwen API key:

```swift
struct Config {
    static let shared = Config()

    var qwenAPIKey: String {
        // Replace with your API key
        return "your-api-key-here"
    }
}
```

### Getting an API Key

1. Visit https://dashscope.console.aliyun.com/
2. Sign up or log in
3. Create an API Key
4. Add it to the Config struct

## Required Permissions

The app requires these permissions (already configured in Info.plist):

- `NSMicrophoneUsageDescription`: "需要使用麦克风进行录音"
- `NSSpeechRecognitionUsageDescription`: "需要使用语音识别将语音转换为文字"

## Running the App

1. Select a target (iPhone Simulator or physical device)
2. Click Run (Cmd + R)
3. Grant permissions when prompted
4. Start recording your first note!

## Architecture Overview

```
┌─────────────────────────────────────────────────────┐
│                      Views                           │
│  (NoteListView, RecordingView, SearchView, etc.)     │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│                   ViewModels                         │
│  (NoteListViewModel, RecordingViewModel, etc.)      │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│                    Services                          │
│  (AudioRecorder, SpeechRecognizer, AIService, etc.)  │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│                  Models & Data                       │
│  (Note, Tag, CoreDataStack, NoteRepository)         │
└─────────────────────────────────────────────────────┘
```

## Features Implemented

✅ Voice Recording (start, pause, resume, stop)
✅ Speech Recognition (Chinese)
✅ AI Summarization (via Alibaba Cloud Qwen)
✅ Note Management (CRUD)
✅ Tag Management (create, edit, delete, assign)
✅ Search (by title, content, tags)
✅ Sharing (system share sheet)
✅ Core Data persistence
✅ MVVM Architecture
✅ SwiftUI Interface

## Testing Checklist

- [ ] App launches successfully
- [ ] Microphone permission requested and granted
- [ ] Speech recognition permission requested and granted
- [ ] Can record audio
- [ ] Can pause/resume recording
- [ ] Can stop recording
- [ ] Speech recognition produces text
- [ ] AI summary is generated (requires valid API key)
- [ ] Notes are saved to Core Data
- [ ] Notes appear in list view
- [ ] Can view note details
- [ ] Can edit notes
- [ ] Can delete notes
- [ ] Can create tags
- [ ] Can assign tags to notes
- [ ] Search works by title
- [ ] Search works by content
- [ ] Search works by tag filter
- [ ] Sharing opens share sheet

## Troubleshooting

### "No such module" errors
- Make sure all Swift files are added to the target
- Clean build folder (Cmd + Shift + K)

### Speech recognition not working
- Check that the device has Chinese language pack
- Settings > General > Keyboard > Keyboards > Add New Keyboard > Chinese

### AI summarization not working
- Verify API key is correctly set
- Check network connection
- Verify Alibaba Cloud API quota

### Core Data issues
- Delete app from simulator/device and reinstall
- Check data model matches xcdatamodeld file

## Next Steps

1. Add unit tests in `VoiceNoteAppTests/`
2. Add UI tests in `VoiceNoteAppUITests/`
3. Implement WeChat SDK for sharing
4. Add audio playback functionality
5. Implement iCloud sync
6. Add widget support
7. iPad interface optimization

## Support

For issues or questions, please refer to the main README.md file.
