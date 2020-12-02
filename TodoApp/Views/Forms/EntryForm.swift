//
//  EntryForm.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/30/20.
//

import SwiftUI

struct EntryForm: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var username: String = ""
    @State var title: String = ""
    @State var completed: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("ToDo")) {
                TextField("Title", text: $title)
                // toggle
            }
            Button("submit", action: submit)
        }
    }
    
    private func submit() {
        let todo = TodoModel(title: self.title)
        APICaller.shared.submit(todo: todo) { value in
            guard let value = value else { return }
            print("RESULT \(value.id)")
            let todo = Todo(context: viewContext)
            todo.id = UUID(uuidString: value.id)
            todo.title = value.title
            todo.status = value.status
            
            try? viewContext.save()
            //self.presentedAsModal = false
        }
    }
}

struct EntryForm_Previews: PreviewProvider {
    static var previews: some View {
        EntryForm()
    }
}
