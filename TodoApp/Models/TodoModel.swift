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
    
    init(title: String, status: String) {
        self.title = title
        self.status = Status(rawValue: status) ?? Status.pending
    }
    
    init(title: String, status: Status = .pending) {
        self.title = title
        self.status = status
    }
    
    private func getJsonRepresentation() -> [String: Any] {
        return [
            "title": title,
            "Status": status
        ]
    }
    
    func getJSONString() -> String? {
        return getJsonRepresentation().jsonString
    }
}
