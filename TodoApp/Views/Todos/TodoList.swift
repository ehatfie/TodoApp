//
//  TodoList.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/30/20.
//

import SwiftUI
import CoreData

struct TodoList: View {
    @Binding var selectedDate: String
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.title, ascending: true)],
        animation: .default)
    var items: FetchedResults<Todo>
    var dataItems: [DecodedObject] = []
    
//    init(selectedDate: String) {
//        self.selectedDate = selectedDate
//
//    }
    
    var body: some View {
        List {
            let filteredItems = items.filter({ item in
                guard let itemDueDate = item.dueDate else { return false }
                print("checking date: \(selectedDate)")
                return itemDueDate == selectedDate
            })
            ForEach(filteredItems) { item in
                TodoCellView(todo: item)
            }
            .onDelete(perform: deleteItems)
            .onAppear{
                print("on appear")
                displayThis()
            }
        }
        .onAppear{
            print("on appear")
            displayThis()
        }
        .frame(minHeight: 10)
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif
            
            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }
    
    func displayThis() {
        let filteredItems = items.filter({ item in
            guard let itemDueDate = item.dueDate else { return false }
            return itemDueDate == selectedDate
        })
        
        print("filtered Items \(filteredItems)")
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.title = "title"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

//struct TodoList_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoList(selectedDate: "")
//    }
//}
