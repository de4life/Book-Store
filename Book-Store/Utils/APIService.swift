import Foundation

class APIService {
    private let apiKey = "ORybEG1EPppURcas03eweXpXCiudzTEz"
    
    enum NetworkError: Error {
        case invalidURL
        case requestFailed(Error)
        case invalidData
        case decodingFailed(Error)
    }
    
    func fetchBooks(for category: Category, completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/current/\(category.name.lowercased()).json?api-key=\(apiKey)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(NetworkError.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(BookAPIResponse.self, from: data)
                
                let books = response.results.books.map { bookResult -> Book in
                    return Book(
                        title: bookResult.title,
                        description: bookResult.description,
                        author: bookResult.author,
                        publisher: bookResult.publisher,
                        bookImageURL: bookResult.bookImageURL,
                        rank: bookResult.rank
                    )
                }
                
                completion(.success(books))
            } catch {
                completion(.failure(NetworkError.decodingFailed(error)))
            }
        }
        
        task.resume()
    }
}

