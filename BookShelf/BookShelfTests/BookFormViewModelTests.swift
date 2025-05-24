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
    
    func testSaveBookDoesNotAddBookIfValidationFails() {
        let viewModel = BookFormViewModel(
            titleValidator: AlwaysInvalidValidator(),
            authorValidator: AlwaysInvalidValidator(),
            isbnValidator: AlwaysInvalidValidator()
        )

        viewModel.title = "Test"
        viewModel.author = "Test Author"
        viewModel.isbn = "1234567890"

        viewModel.saveBook()
        
        XCTAssertEqual(viewModel.savedBooks.count, 0)
    }
    
    func testSaveBookAddsBookIfValidationPasses() {
        let viewModel = BookFormViewModel(
            titleValidator: AlwaysValidValidator(),
            authorValidator: AlwaysValidValidator(),
            isbnValidator: AlwaysValidValidator()
        )

        viewModel.title = "Clean Code"
        viewModel.author = "Robert C. Martin"
        viewModel.isbn = "9780132350884"

        viewModel.saveBook()
        
        XCTAssertEqual(viewModel.savedBooks.count, 1)
        XCTAssertEqual(viewModel.savedBooks.first?.title, "Clean Code")
    }
    
    func testFormIsResetAfterSave() {
        let viewModel = BookFormViewModel(
            titleValidator: AlwaysValidValidator(),
            authorValidator: AlwaysValidValidator(),
            isbnValidator: AlwaysValidValidator()
        )

        viewModel.title = "1984"
        viewModel.author = "Orwell"
        viewModel.isbn = "9780451524935"

        viewModel.saveBook()

        XCTAssertEqual(viewModel.title, "")
        XCTAssertEqual(viewModel.author, "")
        XCTAssertEqual(viewModel.isbn, "")
    }
    
    func testDeleteBookRemovesBook() {
        let viewModel = BookFormViewModel(
            titleValidator: AlwaysValidValidator(),
            authorValidator: AlwaysValidValidator(),
            isbnValidator: AlwaysValidValidator()
        )

        viewModel.title = "1984"
        viewModel.author = "George Orwell"
        viewModel.isbn = "9780451524935"
        viewModel.saveBook()

        XCTAssertEqual(viewModel.savedBooks.count, 1)

        viewModel.deleteBook(at: IndexSet(integer: 0))

        XCTAssertEqual(viewModel.savedBooks.count, 0)
    }
    
    func testDeleteBookWithInvalidIndexDoesNothing() {
        let viewModel = BookFormViewModel(
            titleValidator: AlwaysValidValidator(),
            authorValidator: AlwaysValidValidator(),
            isbnValidator: AlwaysValidValidator()
        )

        viewModel.title = "Brave New World"
        viewModel.author = "Aldous Huxley"
        viewModel.isbn = "9780060850524"
        viewModel.saveBook()

        XCTAssertEqual(viewModel.savedBooks.count, 1)

        viewModel.deleteBook(at: IndexSet(integer: 5))

        XCTAssertEqual(viewModel.savedBooks.count, 1)
    }


}
