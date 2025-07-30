//
//  ViewController.swift
//  BundleTask2
//
//  Created by Giorgi Manjavidze on 30.07.25.
//

import UIKit

final class ViewController: UIViewController {

    private let imageView = UIImageView()
    private let loadButton = UIButton(type: .system)
    private let clearButton = UIButton(type: .system)

    private let sampleURL = URL(string: "https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=800")!
    private let imageID = "unsplash_sample"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true

        loadButton.setTitle("Load Image", for: .normal)
        clearButton.setTitle("Clear Cache", for: .normal)

        loadButton.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearCache), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [loadButton, clearButton])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            stack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.widthAnchor.constraint(equalToConstant: 240),
            stack.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func loadImage() {
        ImageCacheManager.shared.downloadImage(from: sampleURL, id: imageID) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }

    @objc private func clearCache() {
        ImageCacheManager.shared.clearCache()
        imageView.image = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("💥 Memory warning received, clearing cache")
        ImageCacheManager.shared.clearCache()
    }
}
