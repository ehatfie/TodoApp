//
//  JSON.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/20/20.
//

import Foundation

protocol JSONStringConvertible {
    var jsonString: String? {get}
}

extension JSONStringConvertible {
    var jsonString: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Dictionary: JSONStringConvertible { }
extension Array: JSONStringConvertible { }

extension String {
    var jsonObject: Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
