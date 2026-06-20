//
//  UserRolesManagementView.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import SwiftUI

struct UserRolesManagementView: View {

    @State private var users: [AdminUser] = []
    @State private var departments: [Department] = []
    
    private var token: String {
        AuthService.shared.authToken
    }

    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            userListView
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            loadData()
        }
    }
}

// MARK: - TOP HEADER COMPONENT Layout
extension UserRolesManagementView {

    var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("System Users")
                    .font(.title2.bold())
                    .foregroundColor(.primary)

                Text("Tap status badge to toggle active state")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

// MARK: - POLISHED CONTAINER RENDERING LAYOUT
extension UserRolesManagementView {

    var userListView: some View {
        List {
            ForEach(users, id: \.userId) { user in
                VStack(alignment: .leading, spacing: 14) {
                    
                    HStack(alignment: .center, spacing: 14) {
                        Circle()
                            .fill(user.isActive ? Color.blue.opacity(0.12) : Color.gray.opacity(0.18))
                            .frame(width: 46, height: 46)
                            .overlay(
                                Text(getAvatarInitials(for: user))
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(user.isActive ? .blue : .gray)
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(getCleanName(for: user))
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.primary)
                            
                            Text(user.safeEmail)
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                            
                            Text(user.roleName)
                                .font(.system(size: 10, weight: .bold))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(roleBadgeColor(for: user.roleId).opacity(0.12))
                                .foregroundColor(roleBadgeColor(for: user.roleId))
                                .cornerRadius(6)
                        }
                        
                        Spacer()
                        
                        // Interactive dynamic status indicator change tracker
                        Button {
                            toggleStatusTrigger(user.userId)
                        } label: {
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(user.isActive ? Color.green : Color.red)
                                    .frame(width: 8, height: 8)
                                Text(user.isActive ? "Active" : "Suspended")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(user.isActive ? .green : .red)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(user.isActive ? Color.green.opacity(0.08) : Color.red.opacity(0.08))
                            .cornerRadius(20)
                        }
                        .buttonStyle(BorderlessButtonStyle()) // Prevents the whole row from being clicked
                    }
                }
                .padding(.vertical, 6)
                .listRowBackground(Color(.systemBackground))
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    private func roleBadgeColor(for id: Int) -> Color {
        switch id {
        case 1: return .red
        case 2: return .purple
        case 3: return .blue
        default: return .gray
        }
    }

    private func getCleanName(for user: AdminUser) -> String {
        return user.safeName
    }
    
    private func getAvatarInitials(for user: AdminUser) -> String {
        let clean = user.safeName
        let entries = clean.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        if entries.count >= 2 {
            return String((entries[0].prefix(1) + entries[1].prefix(1))).uppercased()
        }
        return String(clean.prefix(2)).uppercased()
    }
}

// MARK: - BEHAVIOR WORKFLOW ENGINE
extension UserRolesManagementView {

    func loadData() {
        AdminUserService.shared.fetchAllUsers(token: token) { fetchedUsers in
            self.users = fetchedUsers
        }
        AdminUserService.shared.fetchDepartments(token: token) { fetchedDepts in
            self.departments = fetchedDepts
        }
    }

    func toggleStatusTrigger(_ id: Int) {
        AdminUserService.shared.toggleUserStatus(token: token, id: id) { _ in
            loadData() // Re-fetches database payload automatically to sync status icons
        }
    }
}
