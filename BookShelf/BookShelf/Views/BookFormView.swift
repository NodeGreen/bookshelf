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


#if DEBUG
import CoreData

#Preview {
    let context = PersistenceController(inMemory: true).container.viewContext
    let vm = BookFormViewModel(context: context)
    return NavigationStack {
        BookFormView(viewModel: vm, prefillISBN: "9781234567890")
    }
}
#endif
