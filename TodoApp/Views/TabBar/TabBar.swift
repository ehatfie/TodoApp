//
//  TabBar.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/24/20.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedIndex: Int = 0 // enum??
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            // add index
            TabBarItem(index: 0, iconName: "clock.fill", label: "Recents", onTap: tabBarItemSelected)
            TabBarItem(index: 1, iconName: "cloud.fill", label: "settings", onTap: tabBarItemSelected)
        }
        .frame(maxWidth: .infinity)
        .background(GeometryReader { parentGeometry in 
            Rectangle()
                .fill(Color(UIColor.systemGray2))
                .frame(width: parentGeometry.size.width, height: 0.5)
                .position(x: parentGeometry.size.width / 2, y: 0)
        })
        .background(Color(UIColor.systemGray6))
    }
    
    func tabBarItemSelected(index: Int) {
        print("tab bar item selected: \(index)")
        self.selectedIndex = index
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
