//
//  TodoModel.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/19/20.
//

import Foundation

struct TodoModel: Encodable {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    private func getJsonRepresentation() -> [String: String] {
        return ["title": title]
    }
    
    func getJSONString() -> String? {
        return getJsonRepresentation().jsonString
    }
}
