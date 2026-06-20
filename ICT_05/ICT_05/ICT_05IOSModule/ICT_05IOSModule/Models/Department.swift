//
//  Untitled.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import Foundation

struct Department: Identifiable, Codable {

    let departmentId: Int
    let departmentName: String
    let isActive: Bool
    let createdAt: String?

    var id: Int {
        departmentId
    }
}
