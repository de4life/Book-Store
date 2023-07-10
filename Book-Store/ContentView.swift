import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = BookViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.books, id: \.title) { book in
                NavigationLink(destination: BookDetailView(book: book)) {
                    BookRowView(book: book)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Bookstore")
            .onAppear {
                viewModel.fetchBooks()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BookRowView: View {
    let book: Book
    
    var body: some View {
        HStack {
            AsyncImage(url: book.bookImageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 120)
            } placeholder: {
                Color.gray
                    .frame(width: 80, height: 120)
            }
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.publicationDate)
                    .font(.subheadline)
            }
        }
    }
}

struct BookRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookRowView(book: Book(title: "Book Title", publicationDate: "2023-01-01", bookImageURL: URL(string: "")!))
            .previewLayout(.fixed(width: 300, height: 100))
            .padding()
    }
}

