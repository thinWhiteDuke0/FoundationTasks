//
//  SenderViewController.swift
//  NotificationTasks1
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import UIKit

final class SenderViewController: UIViewController {

    private let sendButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Sender"

        sendButton.setTitle("Send Notification", for: .normal)
        sendButton.addTarget(self, action: #selector(sendNotification), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(sendButton)

        NSLayoutConstraint.activate([
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func sendNotification() {
        NotificationCenter.default.post(
            name: .customMessage,
            object: nil,
            userInfo: ["message": "🟢 Notification Received!"]
        )
    }
}
