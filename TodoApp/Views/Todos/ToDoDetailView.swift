//
//  ToDoDetailView.swift
//  TodoApp
//
//  Created by Erik Hatfield on 2/5/21.
//

import SwiftUI
// make modifications to existing todo and see more details
struct ToDoDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var presentedAsModal: Bool
    @Binding var todo: Todo
    
    @State var newTitle: String = ""
    
    var body: some View {
        VStack {
            Text("Title: \(todo.title ?? "")")
            Text("Status: \(todo.status ?? "")")
            HStack {
                TextField("this", text: $newTitle)
                Button("Set") { updateTitle() }
            }.padding()
        }
    }
    
    func updateTitle() {
        viewContext.performAndWait {
            todo.title = newTitle
            try? viewContext.save()
        }
    }
}

//struct ToDoDetailView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        ToDoDetailView()
//    }
//}
