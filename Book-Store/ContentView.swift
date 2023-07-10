import SwiftUI

struct ContentView: View {
    let categories = [
        Category(name: "Combined Print and E-Book Fiction"),
        Category(name: "Hardcover Fiction")
       
    ]
    
    var body: some View {
        NavigationView {
            List(categories) { category in
                NavigationLink(destination: BookListView(category: category)) {
                    CategoryRow(category: category)
                }
            }
            .navigationTitle("Categories")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
}

struct CategoryRow: View {
    let category: Category
    
    var body: some View {
        Text(category.name)
            .font(.title2)
            .padding()
    }
}

