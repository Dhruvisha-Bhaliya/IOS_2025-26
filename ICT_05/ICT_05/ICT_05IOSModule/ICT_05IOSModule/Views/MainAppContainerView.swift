//
//  MainAppContainerView.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import SwiftUI

struct MainAppContainerView: View {
    @StateObject private var auth = AuthService.shared
    
    var body: some View {
        Group {
            if auth.isAuthenticated {
                if auth.currentUserRole == 1 {
                    // Validated high clearance security group user → Present Menu Collapse Panel View Workspace
                    AdminSidebarContainerView()
                } else {
                    NonAdminFallbackView(roleId: auth.currentUserRole)
                }
            } else {
                LoginRootView()
            }
        }
    }
}

struct AdminGlobalShellView: View {
    @StateObject private var auth = AuthService.shared
    
    var body: some View {
        TabView {
            NavigationStack {
                VStack {
                    Text("Welcome Back, \(auth.currentUserName)")
                        .font(.title2.bold()).padding()
                    Text("Access Token Scope Approved for Level Role Context: Admin")
                        .font(.footnote).foregroundColor(.gray)
                    Spacer()
                    
                    Button(role: .destructive) {
                        auth.logout()
                    } label: {
                        Label("Terminate Session", systemImage: "power")
                            .padding().frame(maxWidth: .infinity).background(Color.red.opacity(0.15)).cornerRadius(12)
                    }
                    .padding()
                }
                .navigationTitle("Admin Dashboard")
            }
            .tabItem { Label("Dashboard", systemImage: "chart.bar.xaxis") }
            
            UserRolesManagementView()
                .tabItem { Label("User & Roles", systemImage: "person.2.badge.gearshape") }
                
            DepartmentListView()
                .tabItem { Label("Departments", systemImage: "building.2.fill") }
        }
    }
}

struct NonAdminFallbackView: View {
    let roleId: Int
    @StateObject private var auth = AuthService.shared
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.shield.fill")
                .font(.system(size: 60)).foregroundColor(.orange)
            Text("Access Restricted")
                .font(.title2.bold())
            Text("Your current profile (Role ID: \(roleId)) does not have clearance to view the central management system administration views panel.")
                .multilineTextAlignment(.center).foregroundColor(.secondary).padding()
            
            Button("Log Out", action: { auth.logout() })
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
