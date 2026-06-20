//
//  DepartmentListView.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import SwiftUI

struct DepartmentListView: View {

    @StateObject private var vm = DepartmentViewModel()

       @State private var showAddSheet = false

       var body: some View {

           NavigationStack {

               ZStack {

                   LinearGradient(
                       colors: [
                           Color.blue.opacity(0.15),
                           Color.white
                       ],
                       startPoint: .top,
                       endPoint: .bottom
                   )
                   .ignoresSafeArea()

                   ScrollView {

                       VStack(spacing: 20) {

                           // HEADER
                           VStack(alignment: .leading, spacing: 10) {

                               Text("SmartGriev")
                                   .font(.largeTitle.bold())

                               Text("Department Management")
                                   .foregroundColor(.gray)

                               HStack(spacing: 15) {

                                   DashboardCard(
                                       title: "Total",
                                       value: "\(vm.departments.count)",
                                       icon: "building.2.fill",
                                       color: .blue
                                   )

                                   DashboardCard(
                                       title: "Active",
                                       value: "\(vm.departments.filter {$0.isActive}.count)",
                                       icon: "checkmark.circle.fill",
                                       color: .green
                                   )
                               }
                           }
                           .padding()

                           // DEPARTMENT LIST
                           ForEach(vm.departments) { dept in

                               NavigationLink {

                                   EditDepartmentView(
                                       department: dept,
                                       vm: vm
                                   )

                               } label: {

                                   VStack(spacing: 15) {

                                       HStack(alignment: .top) {

                                           ZStack {

                                               Circle()
                                                   .fill(Color.blue.opacity(0.15))
                                                   .frame(width: 60, height: 60)

                                               Image(systemName: "building.columns.fill")
                                                   .font(.title2)
                                                   .foregroundColor(.blue)
                                           }

                                           VStack(alignment: .leading, spacing: 8) {

                                               Text(dept.departmentName)
                                                   .font(.headline)
                                                   .foregroundColor(.black)

                                               Text("Department ID: \(dept.departmentId)")
                                                   .font(.subheadline)
                                                   .foregroundColor(.gray)
                                           }

                                           Spacer()

                                           Text(dept.isActive ? "ACTIVE" : "INACTIVE")
                                               .font(.caption.bold())
                                               .padding(.horizontal, 12)
                                               .padding(.vertical, 6)
                                               .background(
                                                   dept.isActive
                                                   ? Color.green.opacity(0.2)
                                                   : Color.red.opacity(0.2)
                                               )
                                               .foregroundColor(
                                                   dept.isActive
                                                   ? .green
                                                   : .red
                                               )
                                               .cornerRadius(20)
                                       }

                                       Divider()

                                       HStack {

                                           Label(
                                               "Edit",
                                               systemImage: "square.and.pencil"
                                           )
                                           .foregroundColor(.blue)

                                           Spacer()

                                           Button {

                                               vm.deleteDepartment(
                                                   id: dept.departmentId
                                               )

                                           } label: {

                                               Label(
                                                   "Delete",
                                                   systemImage: "trash.fill"
                                               )
                                               .foregroundColor(.red)
                                           }
                                       }
                                   }
                                   .padding()
                                   .background(Color.white)
                                   .cornerRadius(25)
                                   .shadow(
                                       color: .black.opacity(0.08),
                                       radius: 8,
                                       x: 0,
                                       y: 4
                                   )
                                   .padding(.horizontal)
                               }
                           }
                       }
                       .padding(.vertical)
                   }
               }
               .navigationTitle("Departments")
               .toolbar {

                   ToolbarItem(placement: .topBarTrailing) {

                       Button {

                           showAddSheet = true

                       } label: {

                           Image(systemName: "plus.circle.fill")
                               .font(.title)
                               .foregroundColor(.blue)
                       }
                   }
               }
               .sheet(isPresented: $showAddSheet) {

                   AddDepartmentView(vm: vm)
               }
               .onAppear {

                   vm.loadDepartments()
               }
           }
       }
   }

   struct DashboardCard: View {

       let title: String
       let value: String
       let icon: String
       let color: Color

       var body: some View {

           VStack(spacing: 12) {

               Image(systemName: icon)
                   .font(.title)
                   .foregroundColor(color)

               Text(value)
                   .font(.title.bold())

               Text(title)
                   .foregroundColor(.gray)
           }
           .frame(maxWidth: .infinity)
           .padding()
           .background(Color.white)
           .cornerRadius(20)
           .shadow(
               color: .black.opacity(0.05),
               radius: 5
           )
       }
   }
