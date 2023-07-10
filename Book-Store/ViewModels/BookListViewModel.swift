import Foundation

class BookListViewModel: ObservableObject {
    @Published var books: [Book]?
    @Published var isLoading = false
    
    private let category: Category
    private let cacheManager: CacheManager
    private let apiService: APIService
    
    init(category: Category) {
        self.category = category
        self.cacheManager = CacheManager()
        self.apiService = APIService()
        
        fetchBooks()
    }
    
    func fetchBooks() {
        isLoading = true
        
        if let cachedBooks = cacheManager.getBooks(for: category) {
            books = cachedBooks
            isLoading = false
        } else {
            apiService.fetchBooks(for: category) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let books):
                    self.books = books
                    self.cacheManager.saveBooks(books, for: self.category)
                case .failure(let error):
                    print("Error fetching books: \(error.localizedDescription)")
                }
                
                self.isLoading = false
            }
        }
    }
}
