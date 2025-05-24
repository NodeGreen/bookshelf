//
//  AlwaysInvalidValidator.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//



class AlwaysInvalidValidator: FieldValidator {
    func validate(_ input: String) -> Bool { false }
}