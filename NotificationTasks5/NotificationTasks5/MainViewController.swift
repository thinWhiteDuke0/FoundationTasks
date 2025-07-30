//
//  MainViewController.swift
//  NotificationTasks5
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import UIKit

final class MainViewController: UIViewController {

    private let emailLabel = UILabel()
    private let logoutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Main"

        setupUI()
    }

    private func setupUI() {
        emailLabel.text = "Welcome, \(UserSessionManager.shared.email ?? "User")"
        emailLabel.translatesAutoresizingMaskIntoConstraints = false

        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(emailLabel)
        view.addSubview(logoutButton)

        NSLayoutConstraint.activate([
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),

            logoutButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func logoutTapped() {
        UserSessionManager.shared.logout()

        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
}
