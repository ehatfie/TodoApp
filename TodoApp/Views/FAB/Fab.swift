//
//  Fab.swift
//  TodoApp
//
//  Created by Erik Hatfield on 2/18/21.
//

import SwiftUI

struct Fab: View {

    @Binding var presentingModal: Bool
    @State var showingMenu = false // needs to be @State?
    @State var showMenuItem1 = false
    @State var showMenuItem2 = false
    @State var showMenuItem3 = false
    
    var body: some View {
        VStack {
            Spacer()
            if showMenuItem1 {
                MenuItem(icon: "camera.fill")
            }
            
            if showMenuItem2 {
                MenuItem(icon: "photo.on.rectangle")
            }
            
            if showMenuItem3 {
                MenuItem(icon: "square.and.arrow.up.fill")
            }
            
            Button(action: {
                //self.showMenu()
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                    .onTapGesture {
                        self.handleButtonTap()
                    }
                    .onLongPressGesture {
                        print("on long press")
                        self.showMenu()
                    }
            })
            .background(Color.white)
            .cornerRadius(38.5)
            .shadow(color: Color.black.opacity(0.3),
                    radius: 3,
                    x: 3,
                    y: 3)
            .padding()
            
            
            
        }
    }
    
    func handleButtonTap() {
        self.presentingModal = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            if showingMenu {
                self.toggleMenuOff()
                //self.showMenu()
            }
        })
        
    }
    
    func toggleMenuOff() {
        self.showMenuItem1 = false
        self.showMenuItem2 = false
        self.showMenuItem3 = false
    }
    
    func showMenu() {
        withAnimation {
            self.showMenuItem3.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showMenuItem2.toggle()
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                self.showMenuItem1.toggle()
            }
        })
        
        showingMenu = true
    }
}


struct Fab_Previews: PreviewProvider {
    static var previews: some View {
        Fab(presentingModal: .constant(false))
    }
}

struct MenuItem: View {
    
    var icon: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
                .frame(width: 55, height: 55)
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(.white)
                .transition(.move(edge: .trailing))
        }
        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
        .transition(.move(edge: .trailing))
    }
}
