//
//  Theme.swift
//  NotificationTasks4
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import UIKit

enum Theme: String {
    case light
    case dark
}

final class ThemeManager {
    static let shared = ThemeManager()

    private let key = "selectedTheme"

    var currentTheme: Theme {
        get {
            if let saved = UserDefaults.standard.string(forKey: key),
               let theme = Theme(rawValue: saved) {
                return theme
            }
            return .light
        }
    }

    func applyTheme(_ theme: Theme) {
        UserDefaults.standard.setValue(theme.rawValue, forKey: key)

        let interfaceStyle: UIUserInterfaceStyle = (theme == .light) ? .light : .dark
        UIApplication.shared.windows.forEach { $0.overrideUserInterfaceStyle = interfaceStyle }
    }
}
