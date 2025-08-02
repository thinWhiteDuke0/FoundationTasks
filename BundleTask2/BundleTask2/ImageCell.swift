//
//  ImageCell.swift
//  BundleTask2
//
//  Created by Giorgi Manjavidze on 02.08.25.
//


// ImageCell.swift

// ImageCell.swift

import UIKit

final class ImageCell: UITableViewCell {

    private let photoImageView = UIImageView()
    private let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true

        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0

        contentView.addSubview(photoImageView)
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            photoImageView.heightAnchor.constraint(equalToConstant: 80),

            label.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            label.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor)
        ])
    }

    func configure(with item: ImageItem) {
        label.text = item.description ?? item.alt_description ?? "By \(item.user.name)"
        photoImageView.image = nil

        guard let url = URL(string: item.urls.small) else { return }

        ImageCacheManager.shared.downloadImage(from: url, id: item.id) { [weak self] image in
            DispatchQueue.main.async {
                self?.photoImageView.image = image
            }
        }
    }
}
