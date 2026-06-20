//
//  DepartmentService.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import Foundation

class DepartmentService {

    static let shared = DepartmentService()

    private let baseURL = "http://192.168.1.5:5224/api/admin/Department"

    // GET Departments
    func fetchDepartments(completion: @escaping ([Department]) -> Void) {

        guard let url = URL(string: baseURL) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                print("GET Error:", error.localizedDescription)
                return
            }

            guard let data = data else { return }

            do {

                let result = try JSONDecoder().decode(
                    [Department].self,
                    from: data
                )

                DispatchQueue.main.async {
                    completion(result)
                }

            } catch {
                print("Decode Error:", error)
            }

        }.resume()
    }

    // ADD Department
    func addDepartment(
        name: String,
        isActive: Bool,
        completion: @escaping (Bool) -> Void
    ) {

        guard let url = URL(string: baseURL) else { return }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        let body: [String: Any] = [
            "departmentName": name,
            "isActive": isActive
        ]

        request.httpBody = try?
            JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) {
            _, _, error in

            DispatchQueue.main.async {
                completion(error == nil)
            }

        }.resume()
    }

    // UPDATE Department
    func updateDepartment(
        id: Int,
        name: String,
        isActive: Bool,
        completion: @escaping (Bool) -> Void
    ) {

        guard let url = URL(string: "\(baseURL)/\(id)") else {
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "PUT"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        let body: [String: Any] = [
            "departmentName": name,
            "isActive": isActive
        ]

        request.httpBody = try?
            JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) {
            _, _, error in

            DispatchQueue.main.async {
                completion(error == nil)
            }

        }.resume()
    }

    // DELETE Department
    func deleteDepartment(
        id: Int,
        completion: @escaping (Bool) -> Void
    ) {

        guard let url = URL(string: "\(baseURL)/\(id)") else {
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) {
            _, _, error in

            DispatchQueue.main.async {
                completion(error == nil)
            }

        }.resume()
    }
}
