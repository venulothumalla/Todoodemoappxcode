//
//  LoginView.swift
//  Todoo
//
//  Created by fitcoders on 05/03/25.
//
//import SwiftUI
//
//struct LoginView: View {
//    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var errorMessage: String?
//    
//    var body: some View {
//        if isLoggedIn {
//            ContentView() // Navigate to the main content screen if logged in
//        } else {
//            VStack {
//                Text("Login")
//                    .font(.largeTitle)
//                    .bold()
//                    .padding()
//                
//                TextField("Email", text: $email)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                
//                SecureField("Password", text: $password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                
//                if let errorMessage = errorMessage {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                        .padding()
//                }
//                
//                Button(action: login) {
//                    Text("Login")
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding(.bottom, 20)
//            }
//            .padding()
//        }
//    }
//    
//    private func login() {
//        guard !email.isEmpty, !password.isEmpty else {
//            errorMessage = "Email and password cannot be empty."
//            return
//        }
//
//        AuthManager.shared.login(email: email, password: password) { success, error in
//            DispatchQueue.main.async {
//                if success {
//                    isLoggedIn = true
//                } else {
//                    errorMessage = error ?? "Login failed"
//                }
//            }
//        }
//    }
//}



import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager  // ✅ Uses EnvironmentObject
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Text("Login Todoo")
                .font(.largeTitle)
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                authManager.login(email: email, password: password) { success, error in
                    if let error = error {
                        self.errorMessage = error
                    }
                }
            }) {
                Text("Login")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

    
#Preview{
    LoginView()
}
