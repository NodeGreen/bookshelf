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
    
    @Published private(set) var savedBooks: [Book] = []
    
    private let titleValidator: FieldValidator
    private let authorValidator: FieldValidator
    private let isbnValidator: FieldValidator
    
    var canSave: Bool {
        titleValidator.validate(title) &&
        authorValidator.validate(author) &&
        isbnValidator.validate(isbn)
    }
    
    init(titleValidator: FieldValidator = TitleValidator(),
         authorValidator: FieldValidator = AuthorValidator(),
         isbnValidator: FieldValidator = ISBNValidator()) {
        self.titleValidator = titleValidator
        self.authorValidator = authorValidator
        self.isbnValidator = isbnValidator
    }
    
    func saveBook() {
        guard canSave else { return }
        
        let newBook = Book(title: title, author: author, isbn: isbn)
        savedBooks.append(newBook)
        
        resetForm()
    }

    private func resetForm() {
        title = ""
        author = ""
        isbn = ""
    }
}
