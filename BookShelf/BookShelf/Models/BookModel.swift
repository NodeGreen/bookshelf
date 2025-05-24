//
//  Book.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//
import Foundation

struct Book: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var author: String
    var isbn: String
}
