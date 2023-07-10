import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var selectedCategory: Category?
    @Published var bookListViewPresentation: BookListViewPresentation?
    
    private let bookCategories = [
        Category(name: "Fiction"),
        Category(name: "Nonfiction"),
        Category(name: "Mystery"),
        Category(name: "Romance")
    ]
    
    func showBookList() {
        bookListViewPresentation = BookListViewPresentation(categories: bookCategories)
    }
}

struct BookListViewPresentation: Identifiable {
    let id = UUID()
    let categories: [Category]
}

