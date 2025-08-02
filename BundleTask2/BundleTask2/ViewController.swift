// ViewController.swift

// ViewController.swift

import UIKit

final class ViewController: UIViewController {

    private var items: [ImageItem] = []
    private let tableView = UITableView()

    
    private let unsplashAccessKey = "N-cw9NyIUVyRlqEpZKb6J42JqnuUW4mZrcZFLUqUpco"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image List"
        view.backgroundColor = .white

        setupTableView()
        setupClearButton()
        fetchImageList()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.dataSource = self
        tableView.rowHeight = 100
    }

    private func setupClearButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Clear Cache",
            style: .plain,
            target: self,
            action: #selector(clearCache)
        )
    }

    @objc private func clearCache() {
        ImageCacheManager.shared.clearCache()
    }

    private func fetchImageList() {
        let urlString = "https://api.unsplash.com/photos?per_page=20"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue("Client-ID \(unsplashAccessKey)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("❌ Network error:", error ?? "Unknown error")
                return
            }

            do {
                let decoded = try JSONDecoder().decode([ImageItem].self, from: data)
                DispatchQueue.main.async {
                    self.items = decoded
                    self.tableView.reloadData()
                }
            } catch {
                print("❌ JSON decoding error:", error)
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        ImageCacheManager.shared.clearCache()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UITableViewCell()
        }

        cell.configure(with: items[indexPath.row])
        return cell
    }
}
