//
//  FoodModel.swift
//  HammerSystemOnboarding
//
//  Created by Egor Dadugin on 05.04.2023.
//

import Foundation

struct Food: Codable {
    let id: Int
    let name: String
    let price: Int
    let description: String
    let image: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        //case veg
        case price
        case description
        case image = "img"
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.veg = try container.decodeIfPresent(Bool.self, forKey: .veg)
//        self.price = try container.decode(Int.self, forKey: .price)
//        self.description = try container.decode(String.self, forKey: .description)
//        self.image = try container.decode(URL.self, forKey: .image)
//    }
}

struct PresentedFood {
    let name: String
    let price: Int
    let description: String
    let image: URL
}
