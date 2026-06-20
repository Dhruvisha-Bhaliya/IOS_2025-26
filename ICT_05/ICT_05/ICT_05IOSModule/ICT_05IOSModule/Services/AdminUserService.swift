//
//  AdminUserService.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import Foundation

class AdminUserService {

    static let shared = AdminUserService()
    private init() {}

    private let baseURL = "\(APIConfig.baseURL)/api/admin/users"

    // MARK: USERS
    func fetchAllUsers(token: String, completion: @escaping ([AdminUser]) -> Void) {
        guard let url = URL(string: baseURL) else { return completion([]) }

        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: req) { data, _, _ in
            guard let data = data else { return completion([]) }

            do {
                let users = try JSONDecoder().decode([AdminUser].self, from: data)
                DispatchQueue.main.async {
                    completion(users)
                }
            } catch {
                print("USER DECODE ERROR:", error)
                DispatchQueue.main.async { completion([]) }
            }
        }.resume()
    }

    // MARK: DEPARTMENTS
    func fetchDepartments(token: String, completion: @escaping ([Department]) -> Void) {
        guard let url = URL(string: APIConfig.departmentURL) else { return completion([]) }

        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: req) { data, _, _ in
            guard let data = data else { return completion([]) }
            do {
                let depts = try JSONDecoder().decode([Department].self, from: data)
                DispatchQueue.main.async { completion(depts) }
            } catch {
                print("DEPARTMENTS DECODE ERROR:", error)
                DispatchQueue.main.async { completion([]) }
            }
        }.resume()
    }

    // MARK: SAVE / UPDATE
    func saveUser(token: String, id: Int?, payload: [String: Any], completion: @escaping (Bool) -> Void) {
        let isUpdate = id != nil
        let endpoint = isUpdate ? "\(baseURL)/\(id!)" : baseURL
        guard let url = URL(string: endpoint) else { return completion(false) }

        var req = URLRequest(url: url)
        req.httpMethod = isUpdate ? "PUT" : "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        req.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        URLSession.shared.dataTask(with: req) { _, response, _ in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            let success = (200...299).contains(statusCode)
            DispatchQueue.main.async { completion(success) }
        }.resume()
    }

    // MARK: DELETE
    func deleteUser(token: String, id: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(id)") else { return completion(false) }

        var req = URLRequest(url: url)
        req.httpMethod = "DELETE"
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: req) { _, res, _ in
            let ok = (res as? HTTPURLResponse)?.statusCode == 200
            DispatchQueue.main.async { completion(ok) }
        }.resume()
    }

    // MARK: TOGGLE
    func toggleUserStatus(token: String, id: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(id)/toggle-status") else { return completion(false) }

        var req = URLRequest(url: url)
        req.httpMethod = "PUT"
        req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: req) { _, res, _ in
            let ok = (res as? HTTPURLResponse)?.statusCode == 200
            DispatchQueue.main.async { completion(ok) }
        }.resume()
    }
}
