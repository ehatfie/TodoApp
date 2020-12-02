//
//  ModalView.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/19/20.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var presentedAsModal: Bool
    @State var username: String = ""
    @State var title: String = ""
    @State var completed: Bool = false
    
    var body: some View {
        VStack {
            Button("dismiss") {
                self.presentedAsModal = false
            }
            NavigationView {
                EntryForm()
            }
        }
    }
    
//    private func submit() {
//        let todo = TodoModel(title: self.title)
//        APICaller.shared.submit(todo: todo) { value in
//            
//            guard let value = value else { self.presentedAsModal = false; return }
//            print("RESULT \(value.id)")
//            let todo = Todo(context: viewContext)
//            todo.id = UUID(uuidString: value.id)
//            todo.title = value.title
//            todo.status = value.status
//            
//            try? viewContext.save()
//            self.presentedAsModal = false
//        }
//    }
}

//struct ModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalView()
//    }
//}
