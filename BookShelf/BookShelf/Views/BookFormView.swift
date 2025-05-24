//
//  BookFormView.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//


import SwiftUI

struct BookFormView: View {
    
    @StateObject var viewModel: BookFormViewModel = BookFormViewModel()
    
    var body: some View {
        NavigationView {
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
                        // TODO
                    }
                    .disabled(!viewModel.canSave)
                }
            }
            .navigationTitle("Nuovo Libro")
        }
    }
}

#Preview {
    BookFormView()
}
