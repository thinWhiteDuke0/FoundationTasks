//
//  ConfigLoader.swift
//  BundleTasks3
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import Foundation

final class ConfigLoader {
    static func loadConfig() -> AppConfig? {
        guard let url = Bundle.main.url(forResource: "config", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let config = try? JSONDecoder().decode(AppConfig.self, from: data) else {
            return nil
        }
        return config
    }
}
