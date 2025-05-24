//
//  BookFormViewModelTests.swift
//  BookShelfTests
//
//  Created by Endo on 24/05/25.
//

import XCTest
@testable import BookShelf

final class BookFormViewModelTests: XCTestCase {

    func testCanSaveReturnsFalseWhenFieldsAreEmpty() {
        let viewModel = BookFormViewModel()
        XCTAssertFalse(viewModel.canSave)
    }

    func testCanSaveReturnsFalseWhenOnlyTitleIsFilled() {
        let viewModel = BookFormViewModel()
        viewModel.title = "Il Signore degli Anelli"
        XCTAssertFalse(viewModel.canSave)
    }

    func testCanSaveReturnsFalseWhenOnlyTitleAndAuthorAreFilled() {
        let viewModel = BookFormViewModel()
        viewModel.title = "1984"
        viewModel.author = "George Orwell"
        XCTAssertFalse(viewModel.canSave)
    }

    func testCanSaveReturnsTrueWhenAllFieldsAreFilled() {
        let viewModel = BookFormViewModel()
        viewModel.title = "Clean Code"
        viewModel.author = "Robert C. Martin"
        viewModel.isbn = "9780132350884"
        XCTAssertTrue(viewModel.canSave)
    }
    
    func testCanSaveIsFalseWhenOneValidatorFails() {
        let viewModel = BookFormViewModel(
            titleValidator: AlwaysValidValidator(),
            authorValidator: AlwaysValidValidator(),
            isbnValidator: AlwaysInvalidValidator()
        )
        
        viewModel.title = "Clean Code"
        viewModel.author = "Robert Martin"
        viewModel.isbn = "1234567890123"

        XCTAssertFalse(viewModel.canSave)
    }
    
    func testCanSaveIsTrueWhenAllValidatorSucced() {
        let viewModel = BookFormViewModel(
            titleValidator: AlwaysValidValidator(),
            authorValidator: AlwaysValidValidator(),
            isbnValidator: AlwaysValidValidator()
        )
        
        viewModel.title = "Clean Code"
        viewModel.author = "Robert Martin"
        viewModel.isbn = "1234567890123"

        XCTAssertTrue(viewModel.canSave)
    }
}
