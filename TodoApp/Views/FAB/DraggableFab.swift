//
//  DraggableFab.swift
//  TodoApp
//
//  Created by Erik Hatfield on 2/18/21.
//

import SwiftUI

struct DraggableFab: View {
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    var body: some View {
        Image(systemName: "plus.circle.fill")
            .resizable()
            .foregroundColor(.blue)
            .frame(width: 50, height: 50)
            .offset(x: self.currentPosition.width, y: self.currentPosition.height)
            .onTapGesture(perform: {
                debugPrint("Perform you action here")
            })
            .gesture(DragGesture()
                        .onChanged { value in
                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width,
                                                          height: value.translation.height + self.newPosition.height)
                        }
                        .onEnded { value in
                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width,
                                                          height: value.translation.height + self.newPosition.height)

                            self.newPosition = self.currentPosition
                        }
            )
    }
}

struct DraggableFab_Previews: PreviewProvider {
    static var previews: some View {
        DraggableFab()
    }
}
