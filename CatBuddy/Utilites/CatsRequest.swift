//
//  CatsRequest.swift
//  CatBuddy
//
//  Created by Maksym Sabadyshyn on 5/21/20.
//  Copyright © 2020 Maksym Sabadyshyn. All rights reserved.
//

import Foundation

class CatsRequest<Resource : APIResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}

extension CatsRequest : NetworkRequest {
    func decode(_ data: Data) -> [Resource.ModelType]? {
        let decodedData = try? JSONDecoder().decode([Resource.ModelType].self, from: data)
        return decodedData
    }

    func getData(with completion: @escaping (Array<Resource.ModelType>?) -> ()) {
        guard let url = resource.url else {
            return
        }
        load(url, with: completion)
    }
}

protocol APIResource {
    associatedtype ModelType: Decodable
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension APIResource {
    var url: URL? {
        var urlComponents = URLComponents(string: "https://api.thecatapi.com/v1/")
        urlComponents?.path = path
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}

struct CatsResource: APIResource {
    typealias ModelType = Cat
    let path = "images/"
    let queryItems = [
       // URLQueryItem(name: "x-api-key", value: ""),
        URLQueryItem(name: "has_breeds", value: "1"),
        URLQueryItem(name: "limit", value: "100")
    ]
}
