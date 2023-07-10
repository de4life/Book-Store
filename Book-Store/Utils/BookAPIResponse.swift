//
//  BookAPIResponce.swift
//  Book-Store
//
//  Created by Артур Агеев on 10.07.2023.
//

import Foundation

struct BookAPIResponse: Codable {
    let results: BookResults
}

struct BookResults: Codable {
    let books: [BookResult]
}

struct BookResult: Codable {
    let title: String
    let description: String
    let author: String
    let publisher: String
    let bookImageURL: String
    let rank: Int

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case author = "author"
        case publisher = "publisher"
        case bookImageURL = "book_image"
        case rank = "rank"
    }
}
