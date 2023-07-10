import Foundation

class CacheManager {
    private let cacheDirectory: URL
    
    init() {
        cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    func getBooks(for category: Category) -> [Book]? {
        let cacheURL = cacheDirectory.appendingPathComponent("\(category.id).json")
        
        guard let data = try? Data(contentsOf: cacheURL) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        do {
            let books = try decoder.decode([Book].self, from: data)
            return books
        } catch {
            print("Error decoding cached books: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveBooks(_ books: [Book], for category: Category) {
        let cacheURL = cacheDirectory.appendingPathComponent("\(category.id).json")
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(books)
            try data.write(to: cacheURL)
        } catch {
            print("Error encoding and saving books: \(error.localizedDescription)")
        }
    }
}

