//
//  LibraryView.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//


import SwiftUI

struct LibraryView: View {
    @ObservedObject var viewModel: BookFormViewModel
    
    var body: some View {
        List(viewModel.savedBooks) { book in
            VStack(alignment: .leading) {
                Text(book.title).font(.headline)
                Text(book.author).font(.subheadline)
                Text(book.isbn).font(.caption).foregroundColor(.gray)
            }
        }
        .navigationTitle("Libreria")
    }
}
