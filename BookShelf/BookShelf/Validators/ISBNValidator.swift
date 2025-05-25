//
//  ISBNValidator.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//


struct ISBNValidator: FieldValidator {
    func validate(_ input: String) -> Bool {
        let cleanCode = input.replacingOccurrences(of: "-", with: "")
        
        if cleanCode.count == 10 {
            return cleanCode.allSatisfy { $0.isNumber || $0 == "X" }
        } else if cleanCode.count == 13 {
            return cleanCode.hasPrefix("978") || cleanCode.hasPrefix("979")
        }
        
        return false
    }
}
