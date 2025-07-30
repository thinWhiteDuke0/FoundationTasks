//
//  ViewController.swift
//  NotificationTasks6
//
//  Created by Giorgi Manjavidze on 30.07.25.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    private let searchManager = SearchManager()
    private var recentSearches: [String] = []

    private let searchBar = UISearchBar()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Recent Searches"
        setupSearchBar()
        setupTableView()
        loadSearches()
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search something..."
        navigationItem.titleView = searchBar
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
    }

    private func loadSearches() {
        recentSearches = searchManager.getSearches()
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            return
        }

        searchManager.save(searchTerm: text)
        loadSearches()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "searchCell")
        cell.textLabel?.text = recentSearches[indexPath.row]
        return cell
    }
}
