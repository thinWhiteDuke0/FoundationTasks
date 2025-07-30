//
//  ShowCell.swift
//  Networking2
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import UIKit

final class ShowCell: UITableViewCell {
    private let posterImageView = UIImageView()
    private let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        contentView.addSubview(posterImageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 80),
            posterImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with show: TVShow) {
        nameLabel.text = show.name
        if let path = show.posterPath {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            loadImage(from: imageURL)
        } else {
            posterImageView.image = nil
        }
    }

    private func loadImage(from url: URL?) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
