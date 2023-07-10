import SwiftUI

struct BookListView: View {
    let category: Category
    @StateObject private var viewModel: BookListViewModel
    
    init(category: Category) {
        self.category = category
        self._viewModel = StateObject(wrappedValue: BookListViewModel(category: category))
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let books = viewModel.books {
                List(books) { book in
                    BookRow(book: book)
                }
            } else {
                Text("No books found")
                    .font(.headline)
            }
        }
        .navigationTitle(category.name)
        .onAppear {
            viewModel.fetchBooks()
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView(category: Category(name: "Combined Print and E-Book Fiction"))
    }
}

struct BookRow: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(book.title)
                .font(.headline)
            
            Text(book.description)
                .font(.subheadline)
            
            Text("Author: \(book.author)")
                .font(.subheadline)
            
            Text("Publisher: \(book.publisher)")
                .font(.subheadline)
            
            HStack {
                Text("Rank: \(book.rank)")
                    .font(.subheadline)
                
                Spacer()
                
                Button("Buy") {
                    guard let buyURL = URL(string: book.bookImageURL) else { return }
                    UIApplication.shared.open(buyURL, options: [:], completionHandler: nil)
                }
                .foregroundColor(.blue)
            }
        }
        .padding()
    }
}

