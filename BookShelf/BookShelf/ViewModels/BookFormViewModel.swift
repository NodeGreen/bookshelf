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
         permssionManager: PermissionsManager = PermissionsManager()) {
        self.context = context
        self.titleValidator = titleValidator
        self.authorValidator = authorValidator
        self.isbnValidator = isbnValidator
        self.permissionManager = permssionManager
        fetchSavedBooks()
    }
    
    func saveBook() {
        guard canSave else { return }
        
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
            print("❌ Errore nel salvare: \(error)")
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
            print("❌ Errore eliminazione: \(error)")
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
            print("❌ Errore fetch: \(error)")
        }
    }
    
    private func resetForm() {
        title = ""
        author = ""
        isbn = ""
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
            print("❌ Permessi non concessi")
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
                print("❌ Codice non valido: \(code)")
            }
            
        case .failure(let error):
            print("❌ Errore scansione: \(error.localizedDescription)")
        }
    }
}
