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
    let status: String
}

class DecodedObjectOuter: Decodable {
    let data: [DecodedObject]
}

class APICaller {
    private var urlString: String = "http://localhost:8080/todos"
    
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
    
    func submit(todo: TodoModel, completion: @escaping (DecodedObject?) -> Void) {
        // convert to json
        // send that bitch
        // return the response
        guard let url = URL(string: urlString) else { completion(nil); return }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let data = try? encoder.encode(todo) else { completion(nil); return }
        print("json string: ", String(data: data, encoding: .utf8)!)
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.uploadTask(with: urlRequest, from: data) { data, response, err in
            print("RESPONSE")
            if let data = data {
                let decoder = JSONDecoder()
                if let string = data as? String {
                    print("STRING \(string)")
                }
                if let foo = try? decoder.decode(String.self, from: data) {
                    print("FOO \(foo)")
                }
                if let json = try? decoder.decode(DecodedObject.self, from: data) {
                    print("GOTTEM", json.title)
                    
                    completion(json)
                } else {
                    print("NO GOTTEM submit")
                }
            }

        }.resume()
    }
}
