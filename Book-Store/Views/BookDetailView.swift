//
//  BookDetailView.swift
//  Book-Store
//
//  Created by Артур Агеев on 05.07.2023.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    
    var body: some View {
        VStack {
            AsyncImage(url: book.bookImageURL) { image in
image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray
            }
            .frame(maxHeight: 300)
            
            Text(book.title)
                .font(.title)
            Text("Publication Date: \(book.publicationDate)")
                .font(.subheadline)
            
            Spacer()
        }
        .padding()
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book(title: "Book Title", publicationDate: "2023-01-01", bookImageURL: URL(string: "https://example.com/image.jpg")!))
    }
}
