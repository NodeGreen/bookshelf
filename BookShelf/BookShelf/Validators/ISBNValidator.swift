//
//  ISBNValidator.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//


struct ISBNValidator: FieldValidator {
    func validate(_ input: String) -> Bool {
        let cleaned = input.trimmingCharacters(in: .whitespaces)
        return cleaned.range(of: #"^\d{10}(\d{3})?$"#, options: .regularExpression) != nil
    }
}
