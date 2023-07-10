//
//  Book.swift
//  Book-Store
//
//  Created by Артур Агеев on 05.07.2023.
//

import Foundation

struct Book: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let author: String
    let publisher: String
    let bookImageURL: String
    let rank: Int
}
