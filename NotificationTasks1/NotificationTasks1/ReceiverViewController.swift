//
//  ReceiverViewController.swift
//  NotificationTasks1
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import UIKit

final class ReceiverViewController: UIViewController {

    private let messageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        title = "Receiver"

        messageLabel.text = "Waiting for notification..."
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 20, weight: .medium)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(_:)),
            name: .customMessage,
            object: nil
        )
    }

    @objc private func handleNotification(_ notification: Notification) {
        if let message = notification.userInfo?["message"] as? String {
            messageLabel.text = message
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("ReceiverViewController deinitialized, observer removed.")
    }
}
