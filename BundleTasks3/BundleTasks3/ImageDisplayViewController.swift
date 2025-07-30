//
//  ImageDisplayViewController.swift
//  BundleTasks3
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import UIKit

final class ImageDisplayViewController: UIViewController, UICollectionViewDataSource {

    private var images: [UIImage] = []
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        loadImages()
        setupCollectionView()
    }

    private func loadImages() {
        // Just show these three images for now to test
        for i in 1...3 {
            if let image = UIImage(named: "img\(i)") {
                print("✅ Loaded: img\(i)")
                images.append(image)
            } else {
                print("❌ Not found: img\(i)")
            }
        }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBlue // test color
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.configure(with: images[indexPath.item])
        return cell
    }
}
