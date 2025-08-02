//
//  ImageItem.swift
//  BundleTask2
//
//  Created by Giorgi Manjavidze on 02.08.25.
//


// ImageItem.swift



import Foundation

struct ImageItem: Decodable {
    let id: String
    let description: String?
    let alt_description: String?
    let user: User
    let urls: Urls

    struct Urls: Decodable {
        let small: String
    }

    struct User: Decodable {
        let name: String
    }
}
