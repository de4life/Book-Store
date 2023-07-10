//
//  BookViewModel.swift
//  Book-Store
//
//  Created by Артур Агеев on 05.07.2023.
//

import Foundation

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    
    func fetchBooks() {
        
        let apiKey = "SMdCBTcROND7N4WFuhF5nkSXAF6G3X8i"
        
        // Build the API request URL
        let urlString = "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create the URL request
        let request = URLRequest(url: url)
        
        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString ?? "")
                }
                    do {
                        // Decode the JSON response
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                        
                        let response = try decoder.decode(Response.self, from: data)
                        
                        // Extract book cover image URL and update the books array
                        let booksWithImages = response.results.map { book in
                        Book(title: book.title,
                        publicationDate: book.publicationDate,
                        bookImageURL: URL(string: book.bookImageURL)!)
                                            }
                        
                        DispatchQueue.main.async {
                            self.books = response.results
                        }
                    } catch {
                        print("Error decoding JSON: \(error.localizedDescription)")
                    }
                }
            }.resume()
    }
}

