//
//  EditDepartmentView.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import SwiftUI

struct EditDepartmentView: View {

    let department: Department

    @ObservedObject var vm: DepartmentViewModel

    @Environment(\.dismiss) var dismiss

    @State private var departmentName = ""

    @State private var isActive = true

    var body: some View {

        Form {

            Section("Update Department") {

                TextField(
                    "Department Name",
                    text: $departmentName
                )

                Toggle(
                    "Active",
                    isOn: $isActive
                )
            }

            Button {

                vm.updateDepartment(
                    id: department.departmentId,
                    name: departmentName,
                    isActive: isActive
                )

                dismiss()

            } label: {

                HStack {

                    Spacer()

                    Label(
                        "Update Department",
                        systemImage: "square.and.arrow.down"
                    )

                    Spacer()
                }
            }
        }
        .navigationTitle("Edit Department")
        .onAppear {

            departmentName = department.departmentName
            isActive = department.isActive
        }
    }
}
