//
//  FieldValidator.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import Foundation

protocol FieldValidator {
    func validate(_ input: String) -> Bool
}
