import Foundation
import SwiftUI
import UIKit

struct HapticsManager {
    static let instance = HapticsManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

class Haptics {
    
    @AppStorage("isHapticsOn") var isHapticsOn: Bool = true
    
    func haptics(type: String) {
        switch(type) {
        case "light":
            lightHaptics()
        case "medium":
            mediumHaptics()
        case "heavy":
            heavyHaptics()
        case "success":
            successHaptics()
        case "warning":
            warningHaptics()
        case "error":
            errorHaptics()
        default:
            mediumHaptics()
        }
    }
    
    private func lightHaptics() {
        if isHapticsOn {
            HapticsManager.instance.impact(style: .light)
        }
    }
    
    private func mediumHaptics() {
        if isHapticsOn {
            HapticsManager.instance.impact(style: .medium)
        }
    }
    
    private func heavyHaptics() {
        if isHapticsOn {
            HapticsManager.instance.impact(style: .heavy)
        }
    }
    
    private func successHaptics() {
        if isHapticsOn {
            HapticsManager.instance.notification(type: .success)
        }
    }
    
    private func warningHaptics() {
        if isHapticsOn {
            HapticsManager.instance.notification(type: .warning)
        }
    }
    
    private func errorHaptics() {
        if isHapticsOn {
            HapticsManager.instance.notification(type: .error)
        }
    }
}


