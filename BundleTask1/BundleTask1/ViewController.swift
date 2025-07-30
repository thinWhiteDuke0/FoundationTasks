//
//  ViewController.swift
//  BundleTask1
//
//  Created by Giorgi Manjavidze on 30.07.25.
//

import UIKit

final class ViewController: UIViewController {

    private let textView = UITextView()
    private let saveButton = UIButton(type: .system)
    private let loadButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 8

        saveButton.setTitle("Save", for: .normal)
        loadButton.setTitle("Load", for: .normal)

        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [saveButton, loadButton])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(textView)
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 200),

            stack.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.widthAnchor.constraint(equalToConstant: 200),
            stack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func saveTapped() {
        let text = textView.text ?? ""
        do {
            try FileManagerHelper.shared.save(text: text)
            showAlert("Saved!", message: "Text saved to file.")
        } catch {
            showAlert("Error", message: "Could not save file.")
        }
    }

    @objc private func loadTapped() {
        do {
            let text = try FileManagerHelper.shared.load()
            textView.text = text
            showAlert("Loaded!", message: "Text loaded from file.")
        } catch {
            showAlert("Error", message: "Could not load file.")
        }
    }

    private func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


