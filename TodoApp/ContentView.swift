//
//  ContentView.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/18/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.title, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    private var dataItems: [DecodedObject] = []

    var body: some View {
        VStack {
            HStack {
                Button("Add Random", action: addRandom)
                Button("Add 3 random", action: addMultipleRandom)
                Button("FETCH", action: fetchData)
                Button("DELETE", action: deleteAll)
            }
            
            List {
                ForEach(items) { item in
                    HStack {
                        Text(item.title!)
                        Text("is completed: \(getIsCompleted(isCompleted: item.completed))")
                    }
                }
                .onDelete(perform: deleteItems)
//                ForEach(dataItems) { item in
//                    Text("Item at \(item, formatter: itemFormatter)")
//                }
//                .onDelete(perform: deleteItems)
            }
            .toolbar {
                #if os(iOS)
                EditButton()
                #endif
                
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        
        
    }
    
    private func getIsCompleted(isCompleted: Bool) -> String {
        return isCompleted ? "TRUE" : "False"
    }
    
    private func fetchData() {
        APICaller.shared.fetchData { data in
            print("received \(data.count) values")
            DispatchQueue.main.async {
                self.addResult(data: data)
            }

        }
    }
    
    private func search() {
        
    }
    
    private func addMultipleRandom() {
        let count = 3
        for _ in 0 ..< count {
            addRandom()
        }
    }
    
    private func addRandom() {
        var gen = SystemRandomNumberGenerator()
        
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.title = "\(items.count)"
            newItem.completed = gen.next() % 2 == 0
            try? self.viewContext.save()
        }
    }
    
    private func addResult(data: DecodedObject) {
        
        withAnimation {
            print("adding result \(data.id)")
            let newItem = Item(context: viewContext)
            
            newItem.title = data.id
            newItem.completed = data.completed
            try? viewContext.save()
//            do {
//
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
            
        }
    }
    
    private func addResult(data: [DecodedObject]) {
       // withAnimation {
            print("Animation")
            //for value in data {
            data.forEach { value in
                
                print("ADDING ", value.id)
                let newItem = Item(context: viewContext)
                newItem.title = value.title
                newItem.completed = value.completed
            
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
            //}
       // }
        print("add result end", items.count)
    }
    
    private func deleteAll() {
        var indexSet = IndexSet()
        //var values = [Int]()
        let upperBound = min(5, items.count)
        for i in 0 ..< upperBound {
            indexSet.insert(i)
        }
        
        self.deleteItems(offsets: indexSet)
//        var itemsToDelete = items.prefix(5)
        
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
