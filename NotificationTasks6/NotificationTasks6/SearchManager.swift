//
//  SearchManager.swift
//  NotificationTasks6
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import Foundation

final class SearchManager {
    private let key = "recentSearches"
    private let maxSearches = 5
    private let defaults = UserDefaults.standard

    func save(searchTerm: String) {
        var searches = getSearches()
        
        // Remove if already exists to avoid duplicates
        searches.removeAll { $0 == searchTerm }

        // Add new search to top
        searches.insert(searchTerm, at: 0)

        // Keep only last 5
        if searches.count > maxSearches {
            searches = Array(searches.prefix(maxSearches))
        }

        defaults.set(searches, forKey: key)
    }

    func getSearches() -> [String] {
        return defaults.stringArray(forKey: key) ?? []
    }
}
