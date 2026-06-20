//
//  AuthenticationModels.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import Foundation

// API Response Container Wrapping
struct ApiResponse<T: Codable>: Codable {
    let status: Bool
    let statusCode: Int?
    let message: String?
    let data: T?
}

// User Model Matching Entity Framework
struct User: Codable, Identifiable {
    var id: Int { userId }
    let userId: Int
    let roleId: Int
    let fullName: String?
    let email: String?
    let mobileNo: String?
    let departmentId: Int?
}

// Global App Session Store
struct LoginDataResponse: Codable {
    let token: String
    let userId: Int
    let roleId: Int
    let type: String
    let name: String?
    let departmentId: Int?
}

struct OtpResponse: Codable {
    let mobile_no: String?
}
