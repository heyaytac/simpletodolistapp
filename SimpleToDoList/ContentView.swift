//
//  ContentView.swift
//  SimpleToDoList
//
//  Created by Privat on 10.09.24.
//

import SwiftUI
import Usercentrics
import UsercentricsUI

struct ContentView: View {
    @State private var todoItems: [TodoItem] = []
    @State private var newItemTitle = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(todoItems) { item in
                    HStack {
                        Text(item.title)
                        Spacer()
                        if item.isCompleted {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                    .onTapGesture {
                        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
                            todoItems[index].isCompleted.toggle()
                        }
                    }
                }
                .onDelete(perform: deleteItems)

                HStack {
                    TextField("New Task", text: $newItemTitle)
                    Button(action: addItem) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newItemTitle.isEmpty)
                }
            }
            .navigationTitle("To-Do List of Aytac")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: showSecondLayer) {
                        Image(systemName: "shield")
                    }
                }
            }
        }
    }

    func addItem() {
        let newItem = TodoItem(title: newItemTitle)
        todoItems.append(newItem)
        newItemTitle = ""
    }

    func deleteItems(at offsets: IndexSet) {
        todoItems.remove(atOffsets: offsets)
    }

    func showSecondLayer() {
        let banner = UsercentricsBanner()
        banner.showSecondLayer { userResponse in
            // Handle user response here
            print("User interaction: \(userResponse.userInteraction)")
            // You may want to apply consents here
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
