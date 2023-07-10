import SwiftUI

struct BookDetailView: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(book.title)
                .font(.title)
            
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
        .navigationTitle(book.title)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let book = Book(title: "Book Title", description: "Book Description", author: "Book Author", publisher: "Book Publisher", bookImageURL: "", rank: 1)
        BookDetailView(book: book)
    }
}

