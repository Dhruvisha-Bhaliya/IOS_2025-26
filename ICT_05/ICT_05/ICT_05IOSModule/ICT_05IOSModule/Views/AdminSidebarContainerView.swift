//
//  AdminSidebarContainerView.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import SwiftUI

enum AdminTab {
    case stats
    case users
    case departments
}

struct AdminSidebarContainerView: View {
    @State private var currentTab: AdminTab = .stats
    @State private var isMenuExpanded: Bool = false
    
    @StateObject private var userVm = AdminUserViewModel()
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Main App workspace routing matrix
            VStack(spacing: 0) {
                // Customized Control Top Toolbar Header
                HStack {
                    Button {
                        withAnimation(.spring()) { isMenuExpanded.toggle() }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Text(titleForTab(currentTab))
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: { AuthService.shared.logout() }) {
                        Image(systemName: "power").foregroundColor(.red)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 2, y: 2)
                
                // Inner Workspace Layout Views Selection Panel Switcher
                Group {
                    switch currentTab {
                    case .stats:
                        AdminDashboardOverviewView()
                    case .users:
                        UserRolesManagementView()
                    case .departments:
                        DepartmentListView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .disabled(isMenuExpanded)
            
            // Dimmed overlay background shroud
            if isMenuExpanded {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation { isMenuExpanded = false } }
            }
            
            // Drawer Navigation Panel Sidebar Menu Layout Canvas Component
            if isMenuExpanded {
                VStack(alignment: .leading, spacing: 24) {
                    // Profile Node Block
                    VStack(alignment: .leading, spacing: 8) {
                        Image(systemName: "person.shield.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                        Text(AuthService.shared.currentUserName)
                            .font(.headline)
                        Text("Root Admin Profile Context")
                            .font(.caption2).foregroundColor(.secondary)
                    }
                    .padding(.top, 60)
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // Route Navigation buttons row sequence
                    VStack(spacing: 8) {
                        SidebarButton(title: "Overview Analytics", icon: "chart.pie.fill", isSelected: currentTab == .stats) {
                            currentTab = .stats; isMenuExpanded = false
                        }
                        SidebarButton(title: "User & Role Settings", icon: "person.2.badge.gearshape.fill", isSelected: currentTab == .users) {
                            currentTab = .users; isMenuExpanded = false
                        }
                        SidebarButton(title: "Core Departments", icon: "building.columns.fill", isSelected: currentTab == .departments) {
                            currentTab = .departments; isMenuExpanded = false
                        }
                    }
                    
                    Spacer()
                }
                .frame(width: 270)
                .background(Color(.systemBackground))
                .ignoresSafeArea()
                .transition(.move(edge: .leading))
            }
        }
        .onAppear {
            AdminUserService.shared.fetchAllUsers(token: AuthService.shared.authToken) { data in
                DispatchQueue.main.async {
                    self.userVm.users = data
                }
            }
        }
    }
    
    private func titleForTab(_ tab: AdminTab) -> String {
        switch tab {
        case .stats: return "Admin Overview Center"
        case .users: return "System Accounts Directory"
        case .departments: return "Organizational Units"
        }
    }
}

struct SidebarButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(isSelected ? .blue : .secondary)
                Text(title)
                    .font(.body.bold())
                    .foregroundColor(isSelected ? .blue : .primary)
                Spacer()
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.08) : Color.clear)
            .cornerRadius(10)
            .padding(.horizontal, 8)
        }
    }
}
