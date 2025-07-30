//
//  FileHelperError.swift
//  BundleTask1
//
//  Created by Giorgi Manjavidze on 30.07.25.
//


import Foundation

enum FileHelperError: Error {
    case writingFailed
    case readingFailed
}

final class FileManagerHelper {
    static let shared = FileManagerHelper()
    
    private init() {}
    
    private var fileURL: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("userText.txt")
    }
    
    func save(text: String) throws {
        guard let url = fileURL else { throw FileHelperError.writingFailed }
        do {
            try text.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            throw FileHelperError.writingFailed
        }
    }
    
    func load() throws -> String {
        guard let url = fileURL else { throw FileHelperError.readingFailed }
        do {
            return try String(contentsOf: url, encoding: .utf8)
        } catch {
            throw FileHelperError.readingFailed
        }
    }
    
    func filePath() -> URL? {
        return fileURL
    }
}
