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
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.title, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Todo>
    private var dataItems: [DecodedObject] = []
    
    @State var presentingModal = false
    @State var selectedDate = Date().getMonthAndDay() {
        didSet {
            print("did set selectedDate \(selectedDate)")
        }
    }

    var body: some View {
        VStack {
            DatePicker1(selectedDate: $selectedDate, dates: getDates())
            TodoList(selectedDate: $selectedDate)
                .onAppear{
                    displayThis()
                }
            EntryForm()
            HStack {
                Button("Present") { self.presentingModal = true }
                        .sheet(isPresented: $presentingModal) { ModalView(presentedAsModal: self.$presentingModal) }
                Button("Add 3 random", action: addMultipleRandom)
                VStack {
                    Button("Fetch sync", action: fetchData)
                    Button("Fetch async", action: fetchDataAsync)
                }
                
                Button("Delete", action: deleteAll)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.blue, lineWidth: 4)
            )
            TabBar()
        }.frame(maxHeight: .infinity, alignment: .bottom)
        
        
    }
    
    func getDates() -> [Date] {
        let today = Date()
        var returnDates: [Date] = [today]
        
        for i in 1 ... 10 {
            let offset: Double = 60 * 60 * 24 * Double(i)
            let timeInterval = today.timeIntervalSinceNow + offset
            let forwardDate = today.addingTimeInterval(timeInterval)
            let backwardDate = today.addingTimeInterval((timeInterval * -1))
            returnDates.append(forwardDate)
            returnDates.insert(backwardDate, at: 0)
            //print("setting \(forwardDate) and \(backwardDate)")
        }
        
        return returnDates
    }
    
    private func getIsCompleted(isCompleted: Bool) -> String {
        return isCompleted ? "TRUE" : "False"
    }
    
    private func fetchData() {
        APICaller.shared.fetchData { data in
            print("received \(data.count) values")
            DispatchQueue.main.sync {
                self.addResult(data: data)
            }

        }
    }
    
    private func fetchDataAsync() {
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
        
        displayThis()
    }
    
    private func addRandom() {
        var gen = SystemRandomNumberGenerator()
        
        let newItem = Item(context: viewContext)
        newItem.title = "\(items.count)"
        newItem.completed = gen.next() % 2 == 0
        newItem.uuid = UUID()
        let newItem2 = Todo(context: viewContext)
        newItem2.dueDate = self.selectedDate
        newItem2.id = UUID()
        newItem2.status = "completed"
        newItem2.title = "\(items.count)"
        print("saving \(newItem2)")
        do {
            try self.viewContext.save()
            // try self.viewContext.save()
        } catch let e {
            print("Error saving item \(newItem) \(e)")
        }
        
//        withAnimation {
//
//
//        }
    }
    
    private func addResult(data: DecodedObject) {
        
        withAnimation {
            print("adding result \(data.id)")
            let newItem = Item(context: viewContext)
            
            newItem.title = data.id
            newItem.completed = false
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
        print("Animation")
        let resultsToSave = data.filter({ incomingObject in
            return !self.items.contains(where: {$0.id == UUID(uuidString: incomingObject.id)})
        })
        
        resultsToSave.forEach { value in
            print("ADDING ", value.id)
            let newItem = Item(context: viewContext)
            newItem.uuid = UUID(uuidString: value.id)
            newItem.title = value.title
            newItem.completed = false //value.completed
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
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
    
    func displayThis() {
        //self.selectedDate = Date().getMonthAndDay()
        let filteredItems = items.filter({ item in
            guard let itemDueDate = item.dueDate else { return false }
            return itemDueDate == selectedDate
        })
        print("items count \(items.count)")
        items.forEach { val in
            print("item: \(val)")
        }
        print("filtered Items \(filteredItems)")
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
        }
    }
}

/*
 TODO:
    support for delete from backend
    appropriate names for model definitions
    figure out ui
    move form submission to same screen
    
 */
