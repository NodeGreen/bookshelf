//
//  BookFormViewModel.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import Foundation
import Combine
import CoreData
import CodeScanner

final class BookFormViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var isbn: String = ""
    @Published var scannedISBN: String? = nil
    @Published var isShowingScanner = false
    @Published private(set) var savedBooks: [Book] = []
    
    let errorHandler: ErrorHandler
    
    private let titleValidator: FieldValidator
    private let authorValidator: FieldValidator
    private let isbnValidator: FieldValidator
    private let context: NSManagedObjectContext
    private let permissionManager: PermissionsManager
    
    private var fetchedEntities: [BookEntity] = []
    
    var canSave: Bool {
        titleValidator.validate(title) &&
        authorValidator.validate(author) &&
        isbnValidator.validate(isbn)
    }
    
    init(context: NSManagedObjectContext,
         titleValidator: FieldValidator = TitleValidator(),
         authorValidator: FieldValidator = AuthorValidator(),
         isbnValidator: FieldValidator = ISBNValidator(),
         permssionManager: PermissionsManager = PermissionsManager(), errorHandler: ErrorHandler = ErrorHandler()) {
        self.context = context
        self.titleValidator = titleValidator
        self.authorValidator = authorValidator
        self.isbnValidator = isbnValidator
        self.permissionManager = permssionManager
        self.errorHandler = errorHandler
        fetchSavedBooks()
    }
    
    func saveBook() {
        guard canSave else {
            if !titleValidator.validate(title) {
                errorHandler.handle(.bookValidationFailed("Titolo"))
            } else if !authorValidator.validate(author) {
                errorHandler.handle(.bookValidationFailed("Autore"))
            } else if !isbnValidator.validate(isbn) {
                errorHandler.handle(.invalidISBN(isbn))
            }
            return
        }
        
        let book = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: context) as! BookEntity
        book.id = UUID()
        book.title = title
        book.author = author
        book.isbn = isbn
        
        do {
            try context.save()
            fetchSavedBooks()
            resetForm()
        } catch {
            errorHandler.handle(.coreDataSaveFailed(error))
        }
    }
    
    func deleteBook(at offsets: IndexSet) {
        for index in offsets {
            guard index < fetchedEntities.count else { continue }
            let book = fetchedEntities[index]
            context.delete(book)
        }
        do {
            try context.save()
            fetchSavedBooks()
        } catch {
            errorHandler.handle(.coreDataDeleteFailed(error))
        }
    }
    
    private func fetchSavedBooks() {
        let request = BookEntity.fetchRequest()
        request.sortDescriptors = []
        do {
            fetchedEntities = try context.fetch(request)
            savedBooks = fetchedEntities.map {
                $0.toModel()
            }
        } catch {
            errorHandler.handle(.coreDataFetchFailed(error))
        }
    }
    
    private func resetForm() {
        title = ""
        author = ""
        isbn = ""
        scannedISBN = nil
    }
    
    func simulateScanISBN() -> String {
        return "978" + String(Int.random(in: 1000000000...9999999999))
    }
    
    func startScanning() {
        #if targetEnvironment(simulator)
        scannedISBN = simulateScanISBN()
        #else
        if permissionManager.hasCameraPermission() {
            isShowingScanner = true
        } else {
            errorHandler.handle(.cameraPermissionDenied)
        }
        #endif
    }
    
    func handleScanResult(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let scanResult):
            let code = scanResult.string
            
            if isbnValidator.validate(code) {
                scannedISBN = code
            } else {
                errorHandler.handle(.invalidISBN(code))
            }
            
        case .failure(let error):
            errorHandler.handle(.scanningFailed(error))
        }
    }
}
