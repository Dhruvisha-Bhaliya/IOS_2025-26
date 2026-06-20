//
//  Book_Table+CoreDataProperties.swift
//  BookCoreData_28March
//
//  Created by ICT2Batch1 on 28/03/26.
//
//

import Foundation
import CoreData


extension Book_Table {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book_Table> {
        return NSFetchRequest<Book_Table>(entityName: "Book_Table")
    }

    @NSManaged public var bookid: UUID?
    @NSManaged public var booktitle: String?
    @NSManaged public var author: String?
    @NSManaged public var genre: String?
    @NSManaged public var publishdate: String?
    @NSManaged public var bookdescription: String?

}

extension Book_Table : Identifiable {

}
