//
//  Book.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//
import Foundation

struct Book: Identifiable {
    var id: UUID
    var title: String
    var author: String
    var isbn: String

    init(id: UUID = UUID(), title: String, author: String, isbn: String) {
        self.id = id
        self.title = title
        self.author = author
        self.isbn = isbn
    }
}
