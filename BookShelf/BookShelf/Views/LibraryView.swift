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
        List {
            if viewModel.savedBooks.isEmpty {
                VStack(spacing: 12) {
                    Text("Nessun libro salvato")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Image(systemName: "books.vertical")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.4))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            } else {
                ForEach(viewModel.savedBooks) { book in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(book.title).font(.headline)
                        Text(book.author).font(.subheadline)
                        Text(book.isbn).font(.caption).foregroundColor(.gray)
                    }
                }
                .onDelete(perform: viewModel.deleteBook)
            }
        }
        .navigationTitle("Libreria")
        .toolbar {
            EditButton()
        }
    }
}

