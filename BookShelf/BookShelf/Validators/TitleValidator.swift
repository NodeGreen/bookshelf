//
//  TitleValidator.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//


struct TitleValidator: FieldValidator {
    func validate(_ input: String) -> Bool {
        !input.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
