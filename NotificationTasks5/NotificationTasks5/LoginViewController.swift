//
//  LoginViewController.swift
//  NotificationTasks5
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import UIKit

final class LoginViewController: UIViewController {

    private let emailField = UITextField()
    private let loginButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Login"

        setupUI()
    }

    private func setupUI() {
        emailField.placeholder = "Enter email"
        emailField.borderStyle = .roundedRect
        emailField.translatesAutoresizingMaskIntoConstraints = false

        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(emailField)
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            emailField.widthAnchor.constraint(equalToConstant: 250),

            loginButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func loginTapped() {
        guard let email = emailField.text, !email.isEmpty else { return }
        UserSessionManager.shared.login(email: email)

        let mainVC = MainViewController()
        let nav = UINavigationController(rootViewController: mainVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
