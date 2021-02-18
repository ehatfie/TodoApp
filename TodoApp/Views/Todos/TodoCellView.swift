//
//  TodoCellView.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/24/20.
//

import SwiftUI

struct TodoCellView: View {
    @ObservedObject var todo: Todo
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(todo.title ?? "MISSING_TITLE")
                Text(todo.status ?? "NO STATUS")
            }.onAppear{
                print("setting title \(todo.title)")
            }
        }
    }
}

struct TodoCellView_Previews: PreviewProvider {
    static var previews: some View {
        TodoCellView(todo: Todo())
    }
}
