//
//  UserSessionManager.swift
//  NotificationTasks5
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import Foundation

final class UserSessionManager {
    static let shared = UserSessionManager()

    private let emailKey = "userEmail"
    private let loginFlagKey = "isLoggedIn"

    var isLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: loginFlagKey)
    }

    var email: String? {
        UserDefaults.standard.string(forKey: emailKey)
    }

    func login(email: String) {
        UserDefaults.standard.setValue(email, forKey: emailKey)
        UserDefaults.standard.setValue(true, forKey: loginFlagKey)
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: emailKey)
        UserDefaults.standard.setValue(false, forKey: loginFlagKey)
    }
}
