//
//  ScanView.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//


import SwiftUI

struct ScanView: View {
    
    @State private var scannedISBN: String? = nil
    @StateObject private var viewModel = BookFormViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Benvenuto in ShelfScan")
                    .font(.title)
                    .padding(.top, 40)

                Button("Simula scansione ISBN") {
                    scannedISBN = viewModel.simulateScanISBN()
                }
                .buttonStyle(.borderedProminent)

                if let isbn = scannedISBN {
                    NavigationLink("Vai al form", destination: BookFormView(viewModel: viewModel, prefillISBN: isbn))
                        .padding()
                }

                NavigationLink("Vedi libreria") {
                    LibraryView(viewModel: viewModel)
                }
                .padding(.top, 20)

                Spacer()
            }
            .navigationTitle("Scan ISBN")
        }
    }
}
