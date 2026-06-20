//
//  AdminDashboardOverviewView.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import SwiftUI

struct AdminDashboardOverviewView: View {

    @State private var dashboard: DashboardResponse? = nil

    let statusColors: [String: Color] = [
        "Submitted": .blue,
        "Assigned": .purple,
        "In Progress": .orange,
        "Escalated": .red,
        "Resolved": .green,
        "Rejected": .gray
    ]

    var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                // TITLE
                Text("Admin Dashboard")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                if let data = dashboard {

                    // MARK: - TOTAL CARD (BIG DESIGN)
                    TotalCardView(total: data.total)
                        .padding(.horizontal)

                    // MARK: - STATUS GRID (ALL STATUS)
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {

                        ForEach(statusColors.keys.sorted(), id: \.self) { status in

                            StatusMiniBox(
                                title: status,
                                count: statusCount(from: data, status: status),
                                color: statusColors[status] ?? .gray
                            )
                        }
                    }
                    .padding(.horizontal)

                    // MARK: - RECENT COMPLAINTS
                    VStack(alignment: .leading, spacing: 15) {

                        Text("Recent Complaints")
                            .font(.headline)

                        ForEach(data.recent.indices, id: \.self) { i in

                            let c = data.recent[i]

                            ComplaintRow(
                                title: c.title,
                                department: c.dept,
                                status: c.status
                            )
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    .padding(.horizontal)

                    // MARK: - DEPARTMENT PERFORMANCE
                    VStack(alignment: .leading, spacing: 15) {

                        Text("Department Performance")
                            .font(.headline)

                        ForEach(data.departmentStats.indices, id: \.self) { i in

                            let d = data.departmentStats[i]

                            DepartmentRow(
                                department: d.department,
                                total: d.total,
                                breach: d.breach
                            )
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    .padding(.horizontal)

                } else {

                    ProgressView("Loading dashboard...")
                }
            }
            .padding(.vertical)
        }
        .onAppear {
            fetchDashboard()
        }
    }

    // MARK: - API CALL
    func fetchDashboard() {

        guard let url = URL(string: "http://192.168.1.5:5224/api/Complaint/admin-dashboard") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in

            if let error = error {
                print("API ERROR:", error)
                return
            }

            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(DashboardResponse.self, from: data)

                DispatchQueue.main.async {
                    self.dashboard = decoded
                }

            } catch {
                print("DECODE ERROR:", error)
            }

        }.resume()
    }

    // MARK: - STATUS COUNT
    func statusCount(from data: DashboardResponse, status: String) -> Int {
        data.statusData.first(where: { $0.status == status })?.count ?? 0
    }
}
struct TotalCardView: View {

    let total: Int

    var body: some View {

        HStack {

            VStack(alignment: .leading, spacing: 6) {
                Text("Total Complaints")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))

                Text("\(total)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
            }

            Spacer()

            Image(systemName: "doc.text.fill")
                .font(.system(size: 40))
                .foregroundColor(.white.opacity(0.9))
        }
        .padding()
        .background(
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
    }
}

struct StatusMiniBox: View {

    let title: String
    let count: Int
    let color: Color

    var body: some View {

        VStack(spacing: 6) {

            Text("\(count)")
                .font(.title2.bold())
                .foregroundColor(color)

            Text(title)
                .font(.caption2)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(color.opacity(0.12))
        .cornerRadius(12)
    }
}

struct ComplaintRow: View {

    let title: String
    let department: String
    let status: String

    var body: some View {

        HStack {

            VStack(alignment: .leading) {
                Text(title).fontWeight(.semibold)
                Text(department)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(status)
                .font(.caption)
                .padding(6)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
        }
    }
}

struct DepartmentRow: View {

    let department: String
    let total: Int
    let breach: Int

    var body: some View {

        HStack {

            Text(department)

            Spacer()

            Text("\(total)")
                .foregroundColor(.secondary)

            Text("\(breach)")
                .foregroundColor(.red)
                .frame(width: 40)
        }
        .padding(.vertical, 4)
    }
}

struct DashboardResponse: Codable {
    let total: Int
    let slaBreached: Int
    let nearDeadline: Int?
    let resolvedToday: Int
    let statusData: [StatusData]
    let recent: [RecentComplaint]
    let departmentStats: [DepartmentStat]
}

struct StatusData: Codable {
    let status: String
    let count: Int
}

struct RecentComplaint: Codable {
    let title: String
    let dept: String
    let status: String
    let priority: String
    let time: String
}

struct DepartmentStat: Codable {
    let department: String
    let total: Int
    let breach: Int
}
