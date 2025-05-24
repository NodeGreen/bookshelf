//
//  AlwaysValidValidator.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import Foundation

class AlwaysValidValidator: FieldValidator {
    func validate(_ input: String) -> Bool { true }
}
