//
//  BookFormView.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//


import SwiftUI

struct BookFormView: View {
    
    @ObservedObject var viewModel: BookFormViewModel
    var prefillISBN: String? = nil

    var body: some View {
        Form {
            Section(header: Text("Titolo")) {
                TextField("Inserisci titolo", text: $viewModel.title)
            }
            
            Section(header: Text("Autore")) {
                TextField("Inserisci autore", text: $viewModel.author)
            }
            
            Section(header: Text("ISBN")) {
                TextField("Inserisci ISBN", text: $viewModel.isbn)
                    .keyboardType(.numberPad)
            }

            Section {
                Button("Salva libro") {
                    viewModel.saveBook()
                }
                .disabled(!viewModel.canSave)
            }

            NavigationLink("Vedi libreria") {
                LibraryView(viewModel: viewModel)
            }
        }
        .navigationTitle("Nuovo Libro")
        .onAppear {
            if let prefill = prefillISBN, viewModel.isbn.isEmpty {
                viewModel.isbn = prefill
            }
        }
    }
}


#Preview {
    BookFormView(viewModel: BookFormViewModel())
}
