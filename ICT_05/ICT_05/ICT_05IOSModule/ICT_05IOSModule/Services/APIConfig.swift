//
//  APIConfig.swift
//  ICT_05IOSModule
//
//  Created by apple on 31/05/26.
//

import Foundation

struct APIConfig {
    static let baseURL = "http://192.168.1.5:5224"

    static let accountURL = "\(baseURL)/api/identity/Account"
    static let adminUsersURL = "\(baseURL)/api/admin/users"
    static let departmentURL = "\(baseURL)/api/admin/Department"
}
