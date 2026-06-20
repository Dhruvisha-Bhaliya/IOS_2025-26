//
//  DepartmentViewModel.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import Foundation

class DepartmentViewModel: ObservableObject {

    @Published var departments: [Department] = []

    // Load Departments
    func loadDepartments() {

        DepartmentService.shared.fetchDepartments { result in
            self.departments = result
        }
    }

    // Add Department
    func addDepartment(
        name: String,
        isActive: Bool
    ) {

        DepartmentService.shared.addDepartment(
            name: name,
            isActive: isActive
        ) { success in

            if success {
                self.loadDepartments()
            }
        }
    }

    // Update Department
    func updateDepartment(
        id: Int,
        name: String,
        isActive: Bool
    ) {

        DepartmentService.shared.updateDepartment(
            id: id,
            name: name,
            isActive: isActive
        ) { success in

            if success {
                self.loadDepartments()
            }
        }
    }

    // Delete Department
    func deleteDepartment(id: Int) {

        DepartmentService.shared.deleteDepartment(id: id) {
            success in

            if success {
                self.loadDepartments()
            }
        }
    }
}
