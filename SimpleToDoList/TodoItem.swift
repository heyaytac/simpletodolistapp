//
//  TodoItem.swift
//  SimpleToDoList
//
//  Created by Privat on 10.09.24.
//

import Foundation

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}
