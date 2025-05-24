//
//  BookFormViewModelTests.swift
//  BookShelfTests
//
//  Created by Endo on 24/05/25.
//

import XCTest
import CoreData
@testable import BookShelf

final class BookFormViewModelTests: XCTestCase {

    func testCanSaveReturnsFalseWhenFieldsAreEmpty() {
        let context = CoreDataTestHelper.makeInMemoryContext()
        let viewModel = BookFormViewModel(context: context)
        XCTAssertFalse(viewModel.canSave)
    }

    func testCanSaveReturnsFalseWhenOnlyTitleIsFilled() {
        let context = CoreDataTestHelper.makeInMemoryContext()
        let viewModel = BookFormViewModel(context: context)
        viewModel.title = "Il Signore degli Anelli"
        XCTAssertFalse(viewModel.canSave)
    }

    func testCanSaveReturnsFalseWhenOnlyTitleAndAuthorAreFilled() {
        let context = CoreDataTestHelper.makeInMemoryContext()
        let viewModel = BookFormViewModel(context: context)
        viewModel.title = "1984"
        viewModel.author = "George Orwell"
        XCTAssertFalse(viewModel.canSave)
    }

    func testCanSaveReturnsTrueWhenAllFieldsAreFilled() {
        let context = CoreDataTestHelper.makeInMemoryContext()
        let viewModel = BookFormViewModel(context: context)
        viewModel.title = "Clean Code"
        viewModel.author = "Robert C. Martin"
        viewModel.isbn = "9780132350884"
        XCTAssertTrue(viewModel.canSave)
    }
    
    func testCanSaveIsFalseWhenOneValidatorFails() {
        let context = CoreDataTestHelper.makeInMemoryContext()
        let viewModel = BookFormViewModel(
            context: context,
            titleValidator: AlwaysValidValidator(),
            authorValidator: AlwaysValidValidator(),
            isbnValidator: AlwaysInvalidValidator()
        )
        
        viewModel.title = "Clean Code"
        viewModel.author = "Robert Martin"
        viewModel.isbn = "1234567890123"
        XCTAssertFalse(viewModel.canSave)
    }
    
    func testCanSaveIsTrueWhenAllValidatorsSucceed() {
        let context = CoreDataTestHelper.makeInMemoryContext()
        let viewModel = BookFormViewModel(
            context: context,
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
        let context = CoreDataTestHelper.makeInMemoryContext()
        let viewModel = BookFormViewModel(
            context: context,
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
        let context = CoreDataTestHelper.makeInMemoryContext()
        let viewModel = BookFormViewModel(
            context: context,
            titleValidator: AlwaysValidValidator(),
            authorValidator: AlwaysValidValidator(),
            isbnValidator: AlwaysValidValidator()
        )

        viewModel.title = "Clean Code"
        viewModel.author = "Robert C. Martin"
        viewModel.isbn = "9780132350884"
        XCTAssertTrue(viewModel.canSave)
        
        viewModel.saveBook()
        
        XCTAssertEqual(viewModel.savedBooks.count, 1)
        XCTAssertEqual(viewModel.savedBooks.first?.title, "Clean Code")
    }
    
    func testFormIsResetAfterSave() {
        let context = CoreDataTestHelper.makeInMemoryContext()
        let viewModel = BookFormViewModel(
            context: context,
            titleValidator: AlwaysValidValidator(),
            authorValidator: AlwaysValidValidator(),
            isbnValidator: AlwaysValidValidator()
        )

        viewModel.title = "1984"
        viewModel.author = "Orwell"
        viewModel.isbn = "9780451524935"
        
        XCTAssertEqual(viewModel.title, "1984")
        XCTAssertEqual(viewModel.author, "Orwell")
        XCTAssertEqual(viewModel.isbn, "9780451524935")

        viewModel.saveBook()

        XCTAssertEqual(viewModel.title, "")
        XCTAssertEqual(viewModel.author, "")
        XCTAssertEqual(viewModel.isbn, "")
    }
    
    func testDeleteBookRemovesBook() {
        let context = CoreDataTestHelper.makeInMemoryContext()
        let viewModel = BookFormViewModel(
            context: context,
            titleValidator: AlwaysValidValidator(),
            authorValidator: AlwaysValidValidator(),
            isbnValidator: AlwaysValidValidator()
        )

        viewModel.title = "1984"
        viewModel.author = "George Orwell"
        viewModel.isbn = "9780451524935"
        XCTAssertTrue(viewModel.canSave)
        
        viewModel.saveBook()
        XCTAssertEqual(viewModel.savedBooks.count, 1)
        
        viewModel.deleteBook(at: IndexSet(integer: 0))
        XCTAssertEqual(viewModel.savedBooks.count, 0)
    }
    
    func testDeleteBookWithInvalidIndexDoesNothing() {
        let context = CoreDataTestHelper.makeInMemoryContext()
        let viewModel = BookFormViewModel(
            context: context,
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
