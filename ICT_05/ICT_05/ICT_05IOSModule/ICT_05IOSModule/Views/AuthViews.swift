//
//  AuthViews.swift
//  ICT_05IOSModule
//
//  Created by ict2batch1 on 20/05/26.
//

import SwiftUI

struct LoginRootView: View {
    @StateObject private var auth = AuthService.shared
    @State private var emailOrMobile = ""
    @State private var password = ""
    
    @State private var otpInput = ""
    @State private var targetMobile = ""
    @State private var showingOtpVerification = false
    @State private var statusMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 22) {
                Spacer()
                Image(systemName: "shield.radiowaves.left.and.right")
                    .font(.system(size: 70))
                    .foregroundColor(.blue)
                
                Text("SmartGriev Terminal")
                    .font(.title.bold())
                
                if !showingOtpVerification {
                    // Step 1: Account Login Credentials
                    VStack(spacing: 15) {
                        TextField("Email or Mobile Number", text: $emailOrMobile)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        
                        Button {
                            auth.login(emailOrMobile: emailOrMobile, password: password) { success, msg, phone in
                                if success, let safePhone = phone {
                                    self.targetMobile = safePhone
                                    self.showingOtpVerification = true
                                } else {
                                    self.statusMessage = msg
                                }
                            }
                        } label: {
                            Text("Send Verification OTP")
                                .bold()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                    }
                } else {
                    // Step 2: Immediate Multi-Factor OTP Input Validation
                    VStack(spacing: 15) {
                        Text("OTP Sent Successfully")
                            .font(.headline)
                            .foregroundColor(.green)
                        
                        Text("Sent to verification endpoint linked with record \(targetMobile)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        TextField("6-Digit OTP Code", text: $otpInput)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .keyboardType(.numberPad)
                        
                        Button {
                            auth.verifyOtp(mobileNo: targetMobile, otp: otpInput) { success, payload in

                                if success {

                                    self.statusMessage = ""

                                } else {

                                    self.statusMessage = "Invalid OTP"
                                }
                            }
                        } label: {
                            Text("Verify OTP & Access System")
                                .bold()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(12)
                        }
                    }
                }
                
                Text(statusMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                
                Spacer()
                
                NavigationLink("Create Citizen Account", destination: RegisterView())
                    .font(.subheadline)
                    .padding(.bottom, 20)
            }
            .padding()
        }
    }
}

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var fullName = ""
    @State private var email = ""
    @State private var mobile = ""
    @State private var password = ""
    @State private var validationMsg = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Citizen Registration")
                .font(.title2.bold())
                
            TextField("Full Name", text: $fullName).padding().background(Color(.systemGray6)).cornerRadius(10)
            TextField("Email Address", text: $email).padding().background(Color(.systemGray6)).cornerRadius(10).autocapitalization(.none)
            TextField("Mobile Number", text: $mobile).padding().background(Color(.systemGray6)).cornerRadius(10).keyboardType(.phonePad)
            SecureField("Password", text: $password).padding().background(Color(.systemGray6)).cornerRadius(10)
            
            Button {
                AuthService.shared.register(fullName: fullName, email: email, mobileNo: mobile, pass: password) { state, msg in
                    if state {
                        dismiss()
                    } else {
                        validationMsg = msg
                    }
                }
            } label: {
                Text("Register")
                    .foregroundColor(.white).bold().frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(10)
            }
            
            Text(validationMsg).foregroundColor(.red).font(.caption)
        }
        .padding()
    }
}
