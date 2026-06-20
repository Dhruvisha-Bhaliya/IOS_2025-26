//
//  Employee_Table+CoreDataProperties.swift
//  EmployeeRegistrationCoreData_30March
//
//  Created by apple on 30/03/26.
//
//

public import Foundation
public import CoreData


public typealias Employee_TableCoreDataPropertiesSet = NSSet

extension Employee_Table {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee_Table> {
        return NSFetchRequest<Employee_Table>(entityName: "Employee_Table")
    }

    @NSManaged public var dob: String?
    @NSManaged public var email: String?
    @NSManaged public var empid: UUID?
    @NSManaged public var gender: String?
    @NSManaged public var salary: Float
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension Employee_Table : Identifiable {

}
