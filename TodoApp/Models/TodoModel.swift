//
//  TodoModel.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/19/20.
//

import Foundation

enum Status: String, Codable, CaseIterable {
    case pending
    case completed
    // case unknown
}

struct TodoModel: Encodable {
    let title: String
    let status: Status
    let dueDate: String
    
    init(title: String, status: String, dueDate: String) {
        self.title = title
        self.status = Status(rawValue: status) ?? Status.pending
        self.dueDate = dueDate
    }
    
    init(title: String, status: Status = .pending, dueDate: String) {
        self.title = title
        self.status = status
        self.dueDate = dueDate
    }
    
    private func getJsonRepresentation() -> [String: Any] {
        return [
            "title": title,
            "Status": status,
            "dueDate": dueDate
        ]
    }
    
    func getJSONString() -> String? {
        return getJsonRepresentation().jsonString
    }
}
