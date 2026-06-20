//
//  Shop_Table+CoreDataProperties.swift
//  coredata_practise_27March
//
//  Created by ict2batch1 on 27/03/26.
//
//

import Foundation
import CoreData


extension Shop_Table {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shop_Table> {
        return NSFetchRequest<Shop_Table>(entityName: "Shop_Table")
    }

    @NSManaged public var category: String?
    @NSManaged public var date: String?
    @NSManaged public var fooddescription: String?
    @NSManaged public var foodID: UUID?
    @NSManaged public var foodName: String?
    @NSManaged public var price: Float

}

extension Shop_Table : Identifiable {

}
