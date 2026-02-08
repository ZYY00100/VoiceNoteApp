#!/bin/bash

# VoiceNoteApp Xcode Project Setup Script

echo "Creating Xcode project structure..."

# Create xcodeproj directory
mkdir -p VoiceNoteApp.xcodeproj

# Create project.pbxproj file
cat > VoiceNoteApp.xcodeproj/project.pbxproj << 'PBX'
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {

/* Begin PBXBuildFile section */
		AA0001 /* VoiceNoteApp.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0002; };
		AA0003 /* ContentView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0004; };
		AA0005 /* Note.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0006; };
		AA0007 /* Tag.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0008; };
		AA0009 /* CoreDataStack.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0010; };
		AA0011 /* NoteRepository.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0012; };
		AA0013 /* AudioRecorder.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0014; };
		AA0015 /* SpeechRecognizer.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0016; };
		AA0017 /* AIService.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0018; };
		AA0019 /* TranscriptionService.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0020; };
		AA0021 /* NoteProcessor.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0022; };
		AA0023 /* SearchService.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0024; };
		AA0025 /* ShareService.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0026; };
		AA0027 /* NoteListViewModel.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0028; };
		AA0029 /* RecordingViewModel.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0030; };
		AA0031 /* NoteDetailViewModel.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0032; };
		AA0033 /* SearchViewModel.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0034; };
		AA0035 /* TagManagementViewModel.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0036; };
		AA0037 /* NoteListView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0038; };
		AA0039 /* RecordingView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0040; };
		AA0041 /* NoteDetailView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0042; };
		AA0043 /* SearchView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0044; };
		AA0045 /* TagManagementView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0046; };
		AA0047 /* AudioRecorderView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0048; };
		AA0049 /* NoteCardView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0050; };
		AA0051 /* TagChipView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0052; };
		AA0053 /* VoiceNoteApp.xcdatamodeld in Sources */ = {isa = PBXBuildFile; fileRef = AA0054; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		AA0002 /* VoiceNoteApp.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = VoiceNoteApp.swift; sourceTree = "<group>"; };
		AA0004 /* ContentView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ContentView.swift; sourceTree = "<group>"; };
		AA0006 /* Note.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Note.swift; sourceTree = "<group>"; };
		AA0008 /* Tag.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Tag.swift; sourceTree = "<group>"; };
		AA0010 /* CoreDataStack.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = CoreDataStack.swift; sourceTree = "<group>"; };
		AA0012 /* NoteRepository.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = NoteRepository.swift; sourceTree = "<group>"; };
		AA0014 /* AudioRecorder.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AudioRecorder.swift; sourceTree = "<group>"; };
		AA0016 /* SpeechRecognizer.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SpeechRecognizer.swift; sourceTree = "<group>"; };
		AA0018 /* AIService.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AIService.swift; sourceTree = "<group>"; };
		AA0020 /* TranscriptionService.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TranscriptionService.swift; sourceTree = "<group>"; };
		AA0022 /* NoteProcessor.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = NoteProcessor.swift; sourceTree = "<group>"; };
		AA0024 /* SearchService.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SearchService.swift; sourceTree = "<group>"; };
		AA0026 /* ShareService.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ShareService.swift; sourceTree = "<group>"; };
		AA0028 /* NoteListViewModel.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = NoteListViewModel.swift; sourceTree = "<group>"; };
		AA0030 /* RecordingViewModel.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = RecordingViewModel.swift; sourceTree = "<group>"; };
		AA0032 /* NoteDetailViewModel.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = NoteDetailViewModel.swift; sourceTree = "<group>"; };
		AA0034 /* SearchViewModel.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SearchViewModel.swift; sourceTree = "<group>"; };
		AA0036 /* TagManagementViewModel.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TagManagementViewModel.swift; sourceTree = "<group>"; };
		AA0038 /* NoteListView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = NoteListView.swift; sourceTree = "<group>"; };
		AA0040 /* RecordingView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = RecordingView.swift; sourceTree = "<group>"; };
		AA0042 /* NoteDetailView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = NoteDetailView.swift; sourceTree = "<group>"; };
		AA0044 /* SearchView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SearchView.swift; sourceTree = "<group>"; };
		AA0046 /* TagManagementView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TagManagementView.swift; sourceTree = "<group>"; };
		AA0048 /* AudioRecorderView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AudioRecorderView.swift; sourceTree = "<group>"; };
		AA0050 /* NoteCardView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = NoteCardView.swift; sourceTree = "<group>"; };
		AA0052 /* TagChipView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TagChipView.swift; sourceTree = "<group>"; };
		AA0055 /* VoiceNoteApp.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = VoiceNoteApp.app; sourceTree = BUILT_PRODUCTS_DIR; };
		AA0056 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
		AA0054 /* VoiceNoteApp.xcdatamodeld */ = {isa = PBXFileReference; lastKnownFileType = wrapper.xcdatamodel; path = VoiceNoteApp.xcdatamodeld; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		AA0057 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		AA0058 = {
			isa = PBXGroup;
			children = (
				AA0059 /* VoiceNoteApp */,
				AA0060 /* Products */,
			);
			sourceTree = "<group>";
		};
		AA0059 /* VoiceNoteApp */ = {
			isa = PBXGroup;
			children = (
				AA0002 /* VoiceNoteApp.swift */,
				AA0004 /* ContentView.swift */,
				AA0061 /* Models */,
				AA0062 /* ViewModels */,
				AA0063 /* Views */,
				AA0064 /* Services */,
				AA0065 /* Persistence */,
				AA0066 /* Resources */,
				AA0056 /* Info.plist */,
			);
			path = VoiceNoteApp;
			sourceTree = "<group>";
		};
		AA0060 /* Products */ = {
			isa = PBXGroup;
			children = (
				AA0055 /* VoiceNoteApp.app */,
			);
			name = Products;
			sourceTree = "<group>";
		};
		AA0061 /* Models */ = {
			isa = PBXGroup;
			children = (
				AA0006 /* Note.swift */,
				AA0008 /* Tag.swift */,
			);
			path = Models;
			sourceTree = "<group>";
		};
		AA0062 /* ViewModels */ = {
			isa = PBXGroup;
			children = (
				AA0028 /* NoteListViewModel.swift */,
				AA0030 /* RecordingViewModel.swift */,
				AA0032 /* NoteDetailViewModel.swift */,
				AA0034 /* SearchViewModel.swift */,
				AA0036 /* TagManagementViewModel.swift */,
			);
			path = ViewModels;
			sourceTree = "<group>";
		};
		AA0063 /* Views */ = {
			isa = PBXGroup;
			children = (
				AA0038 /* NoteListView.swift */,
				AA0040 /* RecordingView.swift */,
				AA0042 /* NoteDetailView.swift */,
				AA0044 /* SearchView.swift */,
				AA0046 /* TagManagementView.swift */,
				AA0067 /* Components */,
			);
			path = Views;
			sourceTree = "<group>";
		};
		AA0067 /* Components */ = {
			isa = PBXGroup;
			children = (
				AA0048 /* AudioRecorderView.swift */,
				AA0050 /* NoteCardView.swift */,
				AA0052 /* TagChipView.swift */,
			);
			path = Components;
			sourceTree = "<group>";
		};
		AA0064 /* Services */ = {
			isa = PBXGroup;
			children = (
				AA0013 /* AudioRecorder.swift */,
				AA0015 /* SpeechRecognizer.swift */,
				AA0017 /* AIService.swift */,
				AA0019 /* TranscriptionService.swift */,
				AA0021 /* NoteProcessor.swift */,
				AA0011 /* NoteRepository.swift */,
				AA0023 /* SearchService.swift */,
				AA0025 /* ShareService.swift */,
			);
			path = Services;
			sourceTree = "<group>";
		};
		AA0065 /* Persistence */ = {
			isa = PBXGroup;
			children = (
				AA0010 /* CoreDataStack.swift */,
				AA0054 /* VoiceNoteApp.xcdatamodeld */,
			);
			path = Persistence;
			sourceTree = "<group>";
		};
		AA0066 /* Resources */ = {
			isa = PBXGroup;
			children = (
				AA0068 /* Assets.xcassets */,
			);
			path = Resources;
			sourceTree = "<group>";
		};
		AA0068 /* Assets.xcassets */ = {
			isa = PBXGroup;
			children = (
			);
			path = Assets.xcassets;
			sourceTree = "<group>";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		AA0069 /* VoiceNoteApp */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = AA0070;
			buildPhases = (
				AA0071 /* Sources */,
				AA0057 /* Frameworks */,
				AA0072 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = VoiceNoteApp;
			productName = VoiceNoteApp;
			productReference = AA0055 /* VoiceNoteApp.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		AA0073 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1500;
				LastUpgradeCheck = 1500;
				TargetAttributes = {
					AA0069 = {
						CreatedOnToolsVersion = 15.0;
					};
				};
			};
			buildConfigurationList = AA0074;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = AA0058;
			productRefGroup = AA0060 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				AA0069 /* VoiceNoteApp */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		AA0072 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		AA0071 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				AA0001 /* VoiceNoteApp.swift in Sources */,
				AA0003 /* ContentView.swift in Sources */,
				AA0005 /* Note.swift in Sources */,
				AA0007 /* Tag.swift in Sources */,
				AA0009 /* CoreDataStack.swift in Sources */,
				AA0011 /* NoteRepository.swift in Sources */,
				AA0013 /* AudioRecorder.swift in Sources */,
				AA0015 /* SpeechRecognizer.swift in Sources */,
				AA0017 /* AIService.swift in Sources */,
				AA0019 /* TranscriptionService.swift in Sources */,
				AA0021 /* NoteProcessor.swift in Sources */,
				AA0023 /* SearchService.swift in Sources */,
				AA0025 /* ShareService.swift in Sources */,
				AA0027 /* NoteListViewModel.swift in Sources */,
				AA0029 /* RecordingViewModel.swift in Sources */,
				AA0031 /* NoteDetailViewModel.swift in Sources */,
				AA0033 /* SearchViewModel.swift in Sources */,
				AA0035 /* TagManagementViewModel.swift in Sources */,
				AA0037 /* NoteListView.swift in Sources */,
				AA0039 /* RecordingView.swift in Sources */,
				AA0041 /* NoteDetailView.swift in Sources */,
				AA0043 /* SearchView.swift in Sources */,
				AA0045 /* TagManagementView.swift in Sources */,
				AA0047 /* AudioRecorderView.swift in Sources */,
				AA0049 /* NoteCardView.swift in Sources */,
				AA0051 /* TagChipView.swift in Sources */,
				AA0053 /* VoiceNoteApp.xcdatamodeld in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin XCBuildConfiguration section */
		AA0075 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				CODE_SIGN_STYLE = Automatic;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				DEVELOPMENT_TEAM = "";
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = VoiceNoteApp/Info.plist;
				INFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
				INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
				INFOPLIST_KEY_UILaunchScreen_Generation = YES;
				INFOPLIST_KEY_UISupportedInterfaceOrientations = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				PRODUCT_BUNDLE_IDENTIFIER = com.voiceapp.VoiceNoteApp;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SDKROOT = iphoneos;
				SUPPORTED_PLATFORMS = iphoneos;
				SUPPORTS_MACCATALYST = NO;
				SUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD = NO;
				SUPPORTS_MAC_DESIGNED_FOR_MAC_IPAD = NO;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = "DEBUG $(inherited)";
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		AA0076 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				CODE_SIGN_STYLE = Automatic;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				DEVELOPMENT_TEAM = "";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = VoiceNoteApp/Info.plist;
				INFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
				INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
				INFOPLIST_KEY_UILaunchScreen_Generation = YES;
				INFOPLIST_KEY_UISupportedInterfaceOrientations = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				PRODUCT_BUNDLE_IDENTIFIER = com.voiceapp.VoiceNoteApp;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SDKROOT = iphoneos;
				SUPPORTED_PLATFORMS = iphoneos;
				SUPPORTS_MACCATALYST = NO;
				SUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD = NO;
				SUPPORTS_MAC_DESIGNED_FOR_MAC_IPAD = NO;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
				TARGETED_DEVICE_FAMILY = "1,2";
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		AA0077 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = "DEBUG $(inherited)";
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
			};
			name = Debug;
		};
		AA0078 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				SDKROOT = iphoneos;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		AA0070 /* Build configuration list for PBXNativeTarget "VoiceNoteApp" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				AA0075 /* Debug */,
				AA0076 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		AA0074 /* Build configuration list for PBXProject "VoiceNoteApp" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				AA0077 /* Debug */,
				AA0078 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = AA0073 /* Project object */;
}
PBX

echo "Xcode project.pbxproj file created."

echo ""
echo "Project setup complete!"
echo ""
echo "To open in Xcode:"
echo "  open VoiceNoteApp.xcodeproj"
echo ""
