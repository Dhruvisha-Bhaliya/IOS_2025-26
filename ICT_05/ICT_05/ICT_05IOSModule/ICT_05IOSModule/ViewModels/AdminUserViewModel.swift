//
//  AdminUserViewModel.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import Foundation

class AdminUserViewModel: ObservableObject {
    @Published var users: [AdminUser] = []
    
    @Published var selectedRole: String = "Citizen" {
        didSet { syncEmailFromRole() }
    }
    @Published var email: String = "" {
        didSet { syncRoleFromEmail() }
    }
    
    @Published var name: String = ""
    @Published var phone: String = ""
    @Published var selectedDepartmentId: Int = 0
    @Published var isSaving: Bool = false
    
    private var isSyncing = false
    var isEditingMode = false // Flag to keep role/email checks isolated during sync operations
    
    let roles = ["Admin", "Department Head", "Officer", "Citizen"]
    
    private var token: String {
        AuthService.shared.authToken
    }
    
    // MARK: - CREATE / SAVE SYSTEM USER
    func createSystemUser(completion: @escaping (Bool) -> Void) {
        isSaving = true
        
        let roleId: Int
        switch selectedRole {
        case "Admin": roleId = 1
        case "Department Head": roleId = 2
        case "Officer": roleId = 3
        default: roleId = 4
        }
        
        let payload: [String: Any] = [
            "userId": 0,
            "fullName": name.trimmingCharacters(in: .whitespacesAndNewlines),
            "email": email,
            "mobileNo": phone,
            "roleId": roleId,
            "isActive": true,
            "departmentId": (roleId == 2 || roleId == 3) && selectedDepartmentId != 0 ? selectedDepartmentId : NSNull()
        ]
        
        AdminUserService.shared.saveUser(token: token, id: nil, payload: payload) { [weak self] success in
            DispatchQueue.main.async {
                self?.isSaving = false
                completion(success)
            }
        }
    }
    
    // MARK: - UTILITIES
    private func syncEmailFromRole() {
        guard !isSyncing, !isEditingMode else { return }
        isSyncing = true
        
        let prefix = name.lowercased().replacingOccurrences(of: " ", with: "")
        let basePrefix = prefix.isEmpty ? "user" : prefix
        
        switch selectedRole {
        case "Admin":             email = "\(basePrefix)_admin@smartgriev.com"
        case "Department Head":   email = "\(basePrefix)_dept@smartgriev.com"
        case "Officer":           email = "\(basePrefix)_officer@smartgriev.com"
        default:                  email = "\(basePrefix)@gmail.com"
        }
        isSyncing = false
    }
    
    private func syncRoleFromEmail() {
        guard !isSyncing, !isEditingMode else { return }
        isSyncing = true
        
        if email.contains("_admin@smartgriev.com") {
            selectedRole = "Admin"
        } else if email.contains("_dept@smartgriev.com") {
            selectedRole = "Department Head"
        } else if email.contains("_officer@smartgriev.com") {
            selectedRole = "Officer"
        } else if email.contains("@gmail.com") {
            selectedRole = "Citizen"
        }
        isSyncing = false
    }
}
