//
//  BookFormViewModel.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//


import Foundation
import Combine

final class BookFormViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var isbn: String = ""
        
    init() {
        
    }
}
