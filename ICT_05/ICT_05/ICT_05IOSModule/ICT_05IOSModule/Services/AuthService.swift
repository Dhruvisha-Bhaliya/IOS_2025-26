//
//  AuthService.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import Foundation

class AuthService: ObservableObject {
    static let shared = AuthService()
    private let baseURI = "\(APIConfig.baseURL)/api/identity/Account"
    
    @Published var isAuthenticated = false
    @Published var currentUserRole: Int = 4 // Default Citizen
    @Published var currentUserName: String = ""
    @Published var authToken: String = ""

    func login(
        emailOrMobile: String,
        password: String,
        completion: @escaping (Bool, String, String?) -> Void
    ) {

        guard let url = URL(string: "\(baseURI)/login") else {
            completion(false, "Invalid URL", nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "EmailOrMobile": emailOrMobile.trimmingCharacters(in: .whitespacesAndNewlines),
            "Password": password
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in

            DispatchQueue.main.async {

                if let error = error {
                    completion(
                        false,
                        "Network Error: \(error.localizedDescription)",
                        nil
                    )
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(false, "Server not responding", nil)
                    return
                }

                guard let data = data else {
                    completion(false, "No data received", nil)
                    return
                }

                print("========== LOGIN RESPONSE ==========")
                print("Status Code: \(httpResponse.statusCode)")

                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                }

                if let decoded = try? JSONDecoder().decode(
                    ApiResponse<OtpResponse>.self,
                    from: data
                ) {

                    if decoded.status == true {

                        completion(
                            true,
                            decoded.message ?? "OTP Sent",
                            decoded.data?.mobile_no
                        )

                    } else {

                        completion(
                            false,
                            decoded.message ?? "Login Failed",
                            nil
                        )
                    }

                    return
                }

                switch httpResponse.statusCode {

                case 400:
                    completion(false, "Invalid email/mobile or password", nil)

                case 401:
                    completion(false, "Unauthorized access", nil)

                case 404:
                    completion(false, "User not found", nil)

                case 500:
                    completion(false, "Internal server error", nil)

                default:
                    completion(
                        false,
                        "Server Error (\(httpResponse.statusCode))",
                        nil
                    )
                }
            }

        }.resume()
    }
    func verifyOtp(
        mobileNo: String,
        otp: String,
        completion: @escaping (Bool, LoginDataResponse?) -> Void
    ) {

        guard let url = URL(string: "\(baseURI)/verify-otp") else {
            completion(false, nil)
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        let body: [String: Any] = [
            "MobileNo": mobileNo,
            "Otp": otp
        ]

        request.httpBody = try?
            JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) {
            data,
            response,
            error in

            if let error = error {

                print("OTP Error:", error.localizedDescription)

                DispatchQueue.main.async {
                    completion(false, nil)
                }

                return
            }

            guard let data = data else {

                DispatchQueue.main.async {
                    completion(false, nil)
                }

                return
            }

            if let decoded = try? JSONDecoder().decode(
                ApiResponse<LoginDataResponse>.self,
                from: data
            ),
               decoded.status {

                DispatchQueue.main.async {

                    if let payload = decoded.data {

                        self.authToken = payload.token
                        self.currentUserRole = payload.roleId
                        self.currentUserName = payload.name ?? "System User"
                        self.isAuthenticated = true

                        completion(true, payload)

                    } else {

                        completion(false, nil)
                    }
                }

            } else {

                DispatchQueue.main.async {
                    completion(false, nil)
                }
            }

        }.resume()
    }

    func register(
        fullName: String,
        email: String,
        mobileNo: String,
        pass: String,
        completion: @escaping (Bool, String) -> Void
    ) {

        guard let url = URL(string: "\(baseURI)/register") else {
            completion(false, "Invalid URL")
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        let body: [String: Any] = [
            "FullName": fullName,
            "Email": email,
            "MobileNo": mobileNo,
            "Password": pass
        ]

        request.httpBody = try?
            JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) {
            data,
            response,
            error in

            guard let data = data else {

                DispatchQueue.main.async {
                    completion(false, "No response from server")
                }

                return
            }

            if let res = try? JSONDecoder().decode(
                ApiResponse<[String: String]>.self,
                from: data
            ) {

                DispatchQueue.main.async {
                    completion(
                        res.status,
                        res.message ?? ""
                    )
                }

            } else {

                DispatchQueue.main.async {
                    completion(
                        false,
                        "Server registration fault structural rejection"
                    )
                }
            }

        }.resume()
    }

    func logout() {

        DispatchQueue.main.async {

            self.isAuthenticated = false
            self.authToken = ""
            self.currentUserRole = 4
            self.currentUserName = ""
        }
    }

    }
