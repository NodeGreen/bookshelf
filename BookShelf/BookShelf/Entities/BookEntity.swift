//
//  BookEntity.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import Foundation
import CoreData

@objc(BookEntity)
public class BookEntity: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var isbn: String?
    
    func toModel() -> Book {
        return Book(
            id: id ?? UUID(),
            title: title ?? "",
            author: author ?? "",
            isbn: isbn ?? ""
        )
    }
}

