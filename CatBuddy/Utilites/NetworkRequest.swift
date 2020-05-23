//
//  NetworkRequest.swift
//  CatBuddy
//
//  Created by Maksym Sabadyshyn on 5/21/20.
//  Copyright © 2020 Maksym Sabadyshyn. All rights reserved.
//

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func getData(with completion: @escaping (ModelType?) -> ())
    func decode(_ data: Data) -> ModelType?
}

extension NetworkRequest {
    func load(_ url: URL, with completion: @escaping (ModelType?) -> ()) {
        var apiKey = ""
        if let filepath = Bundle.main.path(forResource: "api", ofType: "txt") {
            do {
                apiKey = try String(contentsOfFile: filepath)
            } catch {
                completion(nil)
                return
            }
        } else {
           completion(nil)
           return
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(self?.decode(data))
        })
        task.resume()
    }
}

