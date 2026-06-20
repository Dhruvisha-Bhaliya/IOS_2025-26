//
//  Employee+CoreDataProperties.swift
//  coredata_28March
//
//  Created by ICT2Batch1 on 28/03/26.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension Employee : Identifiable {

}
