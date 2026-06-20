//
//  Book_Table+CoreDataProperties.swift
//  LibraryCoreData_30March
//
//  Created by apple on 30/03/26.
//
//

public import Foundation
public import CoreData


public typealias Book_TableCoreDataPropertiesSet = NSSet

extension Book_Table {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book_Table> {
        return NSFetchRequest<Book_Table>(entityName: "Book_Table")
    }

    @NSManaged public var author: String?
    @NSManaged public var bookdescription: String?
    @NSManaged public var bookid: UUID?
    @NSManaged public var booktitle: String?
    @NSManaged public var genre: String?
    @NSManaged public var publishdate: String?

}

extension Book_Table : Identifiable {

}
