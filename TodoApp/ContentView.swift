//
//  ContentView.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/18/20.
//

import SwiftUI
import CoreData

extension Todo {
    static let empty = Todo()
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.title, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Todo>
    private var dataItems: [DecodedObject] = []
    

    var body: some View {
        NavigationView {
            Text("hello")
                .navigationTitle("Navigation")
        }
    }
    
    private func getIsCompleted(isCompleted: Bool) -> String {
        return isCompleted ? "TRUE" : "False"
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

//struct FloatingView: View {
//
//    @State private var currentPosition: CGSize = .zero
//    @State private var newPosition: CGSize = .zero
//    @State var presentingModal = false
//
//    var body: some View {
//
//        Image(systemName: "plus.circle.fill")
//            .resizable()
//            .foregroundColor(.blue)
//            .frame(width: 50, height: 50)
//            .offset(x: self.currentPosition.width, y: self.currentPosition.height)
//            .onTapGesture(perform: {
//                debugPrint("Perform you action here")
//                presentingModal = true
//            })
//            .onLongPressGesture(minimumDuration: 0.1) {
//                print("on long press")
//            }
//            .gesture(DragGesture()
//                        .onChanged { value in
//                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width,
//                                                          height: value.translation.height + self.newPosition.height)
//                        }
//                        .onEnded { value in
//                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width,
//                                                          height: value.translation.height + self.newPosition.height)
//
//                            self.newPosition = self.currentPosition
//                        }
//            )
//    }
//}

//                    Button(action: {
//                        print("BUTTON PRESS")
//                        self.presentingModal = true
//                    }, label: {
//                        Text("+")
//                            .font(.system(.largeTitle))
//                            .frame(width: 77, height: 70)
//                            .foregroundColor(Color.white)
//                            .padding(.bottom, 7)
//                    })
//                    .sheet(isPresented: $presentingModal) { ModalView(presentedAsModal: self.$presentingModal)}
//                    .background(Color.blue)
//                    .cornerRadius(38.5)
//                    .padding()
//                    .shadow(color: Color.black.opacity(0.3),
//                            radius: 3,
//                            x: 3,
//                            y: 3)
//                }
//                .padding(.bottom, 30)
//                .frame(alignment: .bottom)
