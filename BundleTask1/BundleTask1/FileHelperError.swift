// FileHelper.swift

import Foundation

enum FileHelperError: Error {
    case invalidFileName
    case writeFailed
    case readFailed
}

final class FileHelper {
    static let shared = FileHelper()

    private init() {}

    private let fileManager = FileManager.default
    private let fileName = "userText.txt"

    private func documentsDirectory() -> URL {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    private func isValidFileName(_ name: String) -> Bool {
        let invalidChars = CharacterSet(charactersIn: "/\\:?%*|\"<>")
        return !name.isEmpty && name.rangeOfCharacter(from: invalidChars) == nil
    }

    func save(text: String) throws {
        guard isValidFileName(fileName) else {
            throw FileHelperError.invalidFileName
        }

        let fileURL = documentsDirectory().appendingPathComponent(fileName)

        if fileManager.fileExists(atPath: fileURL.path) {
            // Append to existing file
            guard let handle = try? FileHandle(forWritingTo: fileURL),
                  let data = ("\n" + text).data(using: .utf8) else {
                throw FileHelperError.writeFailed
            }
            handle.seekToEndOfFile()
            handle.write(data)
            handle.closeFile()
        } else {
            // Write new file
            do {
                try text.write(to: fileURL, atomically: true, encoding: .utf8)
            } catch {
                throw FileHelperError.writeFailed
            }
        }
    }

    func load() throws -> String {
        guard isValidFileName(fileName) else {
            throw FileHelperError.invalidFileName
        }

        let fileURL = documentsDirectory().appendingPathComponent(fileName)

        do {
            return try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            throw FileHelperError.readFailed
        }
    }
}
