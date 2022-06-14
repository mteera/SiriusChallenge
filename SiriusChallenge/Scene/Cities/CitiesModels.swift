//
//  CitiesModels.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.


import UIKit

enum Cities {
    
  // MARK: Use cases
  enum InitialData {
    struct Request {}
    struct Response {
        let cities: [City]
    }
    struct ViewModel {
        let cities: [City]
    }
  }
}

struct City: Codable {
    let country, name: String
    let id: Int
    let coord: Coord
    
    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
    
    static func < (lhs: City, rhs: City) -> Bool {
        return "\(lhs.name) \(lhs.country)".lowercased() < "\(rhs.name) \(lhs.country)".lowercased()
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name.lowercased() == rhs.name.lowercased()
    }
}

struct Coord: Codable {
    let lon, lat: Double
}
