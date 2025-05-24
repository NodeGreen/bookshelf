//
//  LibraryView.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var viewModel: BookFormViewModel
    @State private var isEditMode = false
    @State private var showDeleteConfirmation = false
    @State private var bookToDelete: (index: Int, title: String)?
    
    var body: some View {
        Group {
            if viewModel.savedBooks.isEmpty {
                EmptyStateView(
                    title: "Libreria vuota",
                    icon: "books.vertical",
                    description: "Inizia scansionando il codice ISBN di un libro o aggiungendolo manualmente"
                )
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(Array(viewModel.savedBooks.enumerated()), id: \.element.id) { index, book in
                            HStack {
                                BookCard(book: book)
                                
                                if isEditMode {
                                    Button {
                                        bookToDelete = (index: index, title: book.title)
                                        showDeleteConfirmation = true
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                            .font(.title2)
                                    }
                                    .transition(.scale.combined(with: .opacity))
                                }
                            }
                            .animation(.spring(response: 0.3), value: isEditMode)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("La mia libreria")
        .toolbar {
            if !viewModel.savedBooks.isEmpty {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            withAnimation(.spring(response: 0.3)) {
                                isEditMode.toggle()
                            }
                        } label: {
                            Label(isEditMode ? "Fine modifica" : "Elimina libri", systemImage: isEditMode ? "checkmark" : "trash")
                        }
                        
                        NavigationLink(destination: BookFormView(viewModel: viewModel)) {
                            Label("Aggiungi libro", systemImage: "plus")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .fontWeight(.medium)
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: BookFormView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                            .fontWeight(.medium)
                    }
                }
            }
        }
        .confirmationPopup(
            isPresented: $showDeleteConfirmation,
            title: "Elimina libro",
            message: bookToDelete != nil ? "Sei sicuro di voler eliminare \"\(bookToDelete!.title)\"?" : "Sei sicuro di voler eliminare questo libro?",
            confirmTitle: "Elimina",
            cancelTitle: "Annulla"
        ) {
            if let book = bookToDelete {
                viewModel.deleteBook(at: IndexSet(integer: book.index))
                withAnimation(.spring(response: 0.3)) {
                    isEditMode = false
                }
            }
            bookToDelete = nil
        }
    }
}
