//
//  AppStateObserverViewController.swift
//  NotificationTasks3
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import UIKit

final class AppStateObserverViewController: UIViewController {

    private let logLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabel()
        setupObservers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupLabel() {
        logLabel.text = "Waiting for app state changes..."
        logLabel.numberOfLines = 0
        logLabel.textAlignment = .center
        logLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logLabel)

        NSLayoutConstraint.activate([
            logLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
    }

    @objc private func handleEnterBackground() {
        log("App entered background.")
    }

    @objc private func handleEnterForeground() {
        log("App entered foreground.")
    }

    private func log(_ message: String) {
        print(message)
        logLabel.text = message
    }
}
