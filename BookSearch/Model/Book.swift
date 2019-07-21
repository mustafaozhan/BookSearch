//
//  Book.swift
//  BookSearch
//
//  Created by Mustafa Ozhan on 21/07/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import Foundation

struct BookItem:  Codable {
    let items: [Book]?
}

struct Book: Codable {
    let id: String
    let volumeInfo: VolumeInfo?
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
    let industryIdentifiers: [[String:String]]?
}

struct ImageLinks: Codable {
    let thumbnail: URL?
}
