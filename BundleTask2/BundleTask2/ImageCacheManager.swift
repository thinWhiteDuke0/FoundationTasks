// ImageCacheManager.swift

// ImageCacheManager.swift

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}

    private let fileManager = FileManager.default

    func tempImageURL(for id: String) -> URL? {
        let tempDir = fileManager.temporaryDirectory
        return tempDir.appendingPathComponent("\(id).jpg")
    }

    func downloadImage(from url: URL, id: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = loadImageFromTemp(for: id) {
            completion(cachedImage)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }

            self.saveImageToTemp(data: data, id: id)
            completion(image)
        }.resume()
    }

    private func saveImageToTemp(data: Data, id: String) {
        guard let url = tempImageURL(for: id) else { return }
        try? data.write(to: url)
    }

    private func loadImageFromTemp(for id: String) -> UIImage? {
        guard let url = tempImageURL(for: id), fileManager.fileExists(atPath: url.path) else { return nil }
        return UIImage(contentsOfFile: url.path)
    }

    func clearCache() {
        let tempDir = fileManager.temporaryDirectory
        do {
            let files = try fileManager.contentsOfDirectory(at: tempDir, includingPropertiesForKeys: nil)
            for file in files where file.pathExtension == "jpg" {
                try fileManager.removeItem(at: file)
            }
            print("🧹 Temp cache cleared.")
        } catch {
            print("❌ Failed to clear temp cache:", error)
        }
    }
}
