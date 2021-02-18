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
    @State var selectedDate: Date = Date()
    @State var dueDate: String = ""
    
    var onSubmit: () -> Void
    
    var body: some View {
        Form {
            Section(header: Text("ToDo")) {
                TextField("Title", text: $title)
                // toggle
            }
            DatePicker("Due Date", selection: $selectedDate, displayedComponents: .date)
            Button("submit", action: submit)
        }
    }
    
    private func submit() {
        let todo = Todo(context: viewContext)
        todo.id = UUID()
        todo.title = self.title
        todo.status = Status.pending.rawValue
        todo.dueDate = selectedDate.getMonthAndDay()
        try? viewContext.save()
        onSubmit()
    }
}

struct EntryForm_Previews: PreviewProvider {
    static var previews: some View {
        EntryForm(selectedDate: Date(), onSubmit: {})
    }
}
