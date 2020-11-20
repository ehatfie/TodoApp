//
//  APICaller.swift
//  TodoApp
//
//  Created by Erik Hatfield on 11/18/20.
//

import Foundation

class DecodedObject: Decodable, Identifiable {
    let id: String
    let title: String
    let completed: Bool
}

class DecodedObjectOuter: Decodable {
    let data: [DecodedObject]
}

class APICaller {
    private var urlString: String = "http://localhost:8080/todos/"
    
    static var shared: APICaller = APICaller()
    
    private init() {}
    
    func fetchData(completion: @escaping ([DecodedObject]) -> Void) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, res, err in
                if let data = data {
                    let decoder = JSONDecoder()
                    
//                    print("data", data)
//                    print("res", res)
//                    print("err", err)
                    if let string = data as? String {
                        print("STRING \(string)")
                    }
                    
                    if let json = try? decoder.decode(DecodedObjectOuter.self, from: data) {
                        print("GOTTEM \(json)")
                        completion(json.data)
                    } else {
                        print("NO GOTTEM")
                    }
                }
            }.resume()
        }
    }
}
