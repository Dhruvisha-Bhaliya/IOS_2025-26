//
//  AdminUserModels.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

//
//  AdminUserModels.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import Foundation

struct AdminUser: Codable, Identifiable {
    var id: Int { userId }

    let userId: Int
    let fullName: String?
    let email: String?
    let mobileNo: String?
    let roleId: Int
    let departmentId: Int?
    let isActive: Bool

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case fullName = "fullName"
        case email = "email"
        case mobileNo = "mobileNo"
        case roleId = "roleId"
        case departmentId = "departmentId"
        case isActive = "isActive"
    }

    // SAFE display
    var safeName: String {
        if let name = fullName, !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return name
        }

        return email?
            .components(separatedBy: "@")
            .first?
            .replacingOccurrences(of: "_", with: " ")
            .capitalized ?? "Unknown User"
    }
    var safeEmail: String { email ?? "-" }
    
    var roleName: String {
        switch roleId {
        case 1:
            return "Admin"
        case 2:
            return "Department Head"
        case 3:
            return "Officer"
        default:
            return "Citizen"
        }
    }
}
