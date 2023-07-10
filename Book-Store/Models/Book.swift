//
//  Book.swift
//  Book-Store
//
//  Created by Артур Агеев on 05.07.2023.
//

import Foundation

struct Book: Codable {
    let title: String
    let publicationDate: String
    let bookImageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case title
        case publicationDate = "publish_date"
        case bookImageURL = "book_image"
    }
}
struct Response: Codable {
    let results: [Book]
}
