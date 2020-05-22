//
//  Cat.swift
//  CatBuddy
//
//  Created by Maksym Sabadyshyn on 5/21/20.
//  Copyright © 2020 Maksym Sabadyshyn. All rights reserved.
//

import Foundation

struct Cat {
    let breeds: [Breed]
    let id: String
    let image: String
}

extension Cat: Decodable {
    enum CodingKeys: String, CodingKey {
        case breeds
        case id
        case image = "url"
    }
}

struct Breed: Decodable {
    let name: String
    let temperament: String
    let origin: String
    let description: String
    let dogFriendly: Int
    let energyLevel: Int
    let socialNeeds: Int
}

