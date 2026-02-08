//
//  ShareService.swift
//  VoiceNoteApp
//
//  Created on 2026-02-04.
//

import UIKit
import SwiftUI

class ShareService {
    static func shareText(_ text: String, from view: UIView) {
        let activityViewController = UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootViewController = window.rootViewController {
            rootViewController.present(activityViewController, animated: true)
        }
    }

    static func shareNote(_ note: Note, includeSummary: Bool = true, from view: UIView) {
        var shareContent = note.title + "\n\n"

        if includeSummary && !note.summaryContent.isEmpty {
            shareContent += "总结：\n" + note.summaryContent + "\n\n"
        }

        shareContent += "内容：\n" + note.originalContent

        shareText(shareContent, from: view)
    }

    // Future: WeChat SDK integration
    // func shareToWeChat(_ note: Note, scene: WXScene) { ... }
}
