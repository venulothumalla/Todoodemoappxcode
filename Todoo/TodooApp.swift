//
//  TodooApp.swift
//  Todoo
//
//  Created by fitcoders on 17/01/25.
//

//import SwiftUI
//
//@main
//struct TodooApp: App {
//    var body: some Scene {
//        WindowGroup {
//            LoginView()
//        }
//    }
//}
import SwiftUI

@main
struct TodooApp: App {
    @StateObject var authManager = AuthManager.shared  // ✅ Global State

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)  // ✅ Pass authManager to all views
        }
    }
}



