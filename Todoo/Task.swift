//
//  Task.swift
//  Todoo
//
//  Created by fitcoders on 17/01/25.
//

import Foundation

// Task Model
struct Task: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}
