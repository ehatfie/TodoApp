//
//  TabBarItem.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/24/20.
//

import SwiftUI

struct TabBarItem: View {
    let index: Int
    let iconName: String
    let label: String
    var onTap: (Int) -> Void = {_ in} // is this really something we do? should be optional if so
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .frame(minWidth: 25, minHeight: 25)
            Text(label)
                .font(.caption)
        }
        .foregroundColor(Color(UIColor.systemGray))
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            print("\(label) onTap")
            self.onTap(self.index)
        }
    }
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItem(index: 0, iconName: "cloud.fill", label: "Recents")
            .previewLayout(.fixed(width: 80, height: 80))
    }
}
