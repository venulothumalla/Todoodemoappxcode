//
//  AuthManager.swift
//  Todoo
//
//  Created by fitcoders on 05/03/25.
//

//import Foundation
//
//class AuthManager {
//    static let shared = AuthManager()
//
//    func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
//        guard let url = URL(string: "https://your-api-url.com/login") else {
//            completion(false, "Invalid URL")
//            return
//        }
//
//        let body: [String: Any] = ["email": email, "password": password]
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(false, error.localizedDescription)
//                return
//            }
//
//            guard let data = data else {
//                completion(false, "No data received")
//                return
//            }
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                if let token = json?["data"] as? [String: Any], let accessToken = token["accessToken"] as? String {
//                    UserDefaults.standard.set(accessToken, forKey: "accessToken")
//                    completion(true, nil)
//                } else {
//                    completion(false, "Invalid login credentials")
//                }
//            } catch {
//                completion(false, "Failed to parse response")
//            }
//        }.resume()
//    }
//
//    func logout() {
//        UserDefaults.standard.removeObject(forKey: "accessToken")
//        UserDefaults.standard.set(false, forKey: "isLoggedIn")
//    }
//}

import Foundation

class AuthManager: ObservableObject {
    static let shared = AuthManager()

    @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")

    func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: "https://dev-api.reformrx.net/api/v5/auth") else {
            completion(false, "Invalid URL")
            return
        }

        let body: [String: Any] = ["email": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(false, error.localizedDescription)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, "No data received")
                }
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let tokenData = json?["data"] as? [String: Any],
                   let accessToken = tokenData["accessToken"] as? String {
                    UserDefaults.standard.set(accessToken, forKey: "accessToken")
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")

                    DispatchQueue.main.async {
                        self.isLoggedIn = true
                        completion(true, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false, "Invalid login credentials")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false, "Failed to parse response")
                }
            }
        }.resume()
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")

        DispatchQueue.main.async {
            self.isLoggedIn = false
        }
    }
}
