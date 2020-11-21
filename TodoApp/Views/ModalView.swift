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
    
    var body: some View {
        VStack {
            Button("dismiss") {
                self.presentedAsModal = false
            }
            NavigationView {
                Form {
                    Section(header: Text("ToDo")) {
                        TextField("Title", text: $title)
                    }
                    Button("submit", action: submit)
                }
                .navigationBarTitle("Settings")
            }
        }
    }
    
    private func submit() {
        let todo = TodoModel(title: self.title)
        APICaller.shared.submit(todo: todo) { value in
            print("RESULT", value)
            guard let value = value else { self.presentedAsModal = false; return }
            let item = Item(context: viewContext)
            item.title = value.title
            item.completed = false
            try? viewContext.save()
            self.presentedAsModal = false
        }
    }
}

//struct ModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalView()
//    }
//}
