//
//  BookFormView.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import SwiftUI

struct BookFormView: View {
    @ObservedObject var viewModel: BookFormViewModel
    @Environment(\.dismiss) private var dismiss
    var prefillISBN: String? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    Image(systemName: "book.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("Aggiungi un nuovo libro")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    Text("Compila i campi per aggiungere il libro alla tua libreria")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                FormSection {
                    CustomTextField(
                        title: "Titolo",
                        placeholder: "Es. Il Signore degli Anelli",
                        text: $viewModel.title,
                        icon: "textformat"
                    )
                    
                    CustomTextField(
                        title: "Autore",
                        placeholder: "Es. J.R.R. Tolkien",
                        text: $viewModel.author,
                        icon: "person"
                    )
                    
                    CustomTextField(
                        title: "ISBN",
                        placeholder: "Es. 9781234567890",
                        text: $viewModel.isbn,
                        icon: "barcode",
                        keyboardType: .numberPad
                    )
                }
                
                VStack(spacing: 16) {
                    GradientButton(
                        title: "Salva libro",
                        icon: "checkmark",
                        colors: viewModel.canSave ? [.green, .green.opacity(0.8)] : [.gray, .gray.opacity(0.8)]
                    ) {
                        viewModel.saveBook()
                        if viewModel.canSave {
                            dismiss()
                        }
                    }
                    .disabled(!viewModel.canSave)
                    
                    NavigationLink(destination: LibraryView(viewModel: viewModel)) {
                        HStack {
                            Image(systemName: "books.vertical")
                            Text("Vai alla libreria")
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.blue)
                        .padding(.vertical, 12)
                    }
                }
                
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("Nuovo Libro")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let prefill = prefillISBN, viewModel.isbn.isEmpty {
                viewModel.isbn = prefill
            }
        }
        .withErrorHandling(errorHandler: viewModel.errorHandler)
    }
}
