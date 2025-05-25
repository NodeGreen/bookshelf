//
//  ScanView.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import SwiftUI
import CodeScanner

struct ScanView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject private var viewModel: BookFormViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: BookFormViewModel(context: PersistenceController.shared.container.viewContext))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                VStack(spacing: 16) {
                    Image(systemName: "books.vertical.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("ShelfScan")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("Gestisci la tua libreria personale")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                VStack(spacing: 20) {
                    GradientButton(
                        title: "Scansiona ISBN",
                        icon: "camera.viewfinder"
                    ) {
                        viewModel.startScanning()
                    }
                    
                    if let isbn = viewModel.scannedISBN {
                        VStack(spacing: 12) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("ISBN: \(isbn)")
                                    .fontWeight(.medium)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(8)
                            
                            NavigationLink(destination: BookFormView(viewModel: viewModel, prefillISBN: isbn)) {
                                Text("Completa i dati del libro")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 24)
                                    .background(Color.green)
                                    .cornerRadius(8)
                            }
                        }
                        .transition(.opacity.combined(with: .scale))
                        .animation(.spring(response: 0.5), value: viewModel.scannedISBN)
                    }
                }
                
                VStack(spacing: 16) {
                    NavigationCard(
                        title: "La mia libreria",
                        icon: "books.vertical",
                        destination: AnyView(LibraryView(viewModel: viewModel))
                    )
                    
                    NavigationCard(
                        title: "Aggiungi libro manualmente",
                        icon: "plus.rectangle",
                        destination: AnyView(BookFormView(viewModel: viewModel))
                    )
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $viewModel.isShowingScanner) {
            CodeScannerView(
                codeTypes: [.ean13, .ean8, .upce],
                simulatedData: "9781234567890",
                completion: viewModel.handleScanResult
            )
        }
    }
}

#Preview {
    ScanView()
}    
