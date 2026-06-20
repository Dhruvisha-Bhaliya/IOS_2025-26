//
//  AddDepartmentView.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import SwiftUI

struct AddDepartmentView: View {

    @Environment(\.dismiss) var dismiss

    @ObservedObject var vm: DepartmentViewModel

    @State private var departmentName = ""

    @State private var isActive = true

    var body: some View {

        NavigationView {

            Form {

                Section("Department Details") {

                    TextField(
                        "Department Name",
                        text: $departmentName
                    )

                    Toggle(
                        "Active",
                        isOn: $isActive
                    )
                }
            }
            .navigationTitle("Add Department")
            .toolbar {

                ToolbarItem(placement: .navigationBarLeading) {

                    Button("Cancel") {

                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {

                    Button("Save") {

                        vm.addDepartment(
                            name: departmentName,
                            isActive: isActive
                        )

                        dismiss()
                    }
                }
            }
        }
    }
}
