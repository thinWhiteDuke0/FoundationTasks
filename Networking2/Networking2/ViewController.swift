import UIKit

final class ViewController: UIViewController, UITableViewDataSource {

    private var shows: [TVShow] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Rated Shows"
        view.backgroundColor = .systemBackground
        setupTableView()
        fetchShows()
    }

    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(ShowCell.self, forCellReuseIdentifier: "ShowCell")
        view.addSubview(tableView)
    }

    private func fetchShows() {
        NetworkManager.shared.fetchTopRatedTVShows { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tvShows):
                    self?.shows = tvShows
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }

    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as? ShowCell else {
            return UITableViewCell()
        }
        cell.configure(with: shows[indexPath.row])
        return cell
    }
}
