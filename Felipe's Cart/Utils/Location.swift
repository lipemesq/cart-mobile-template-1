//
//  Location.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 22/11/20.
//

import Foundation

// Just a candy to avoid importing CoreLocation 
struct Location: Codable {
   let lat: Double
   let lon: Double
   
   enum CodingKeys: String, CodingKey {
      case lat = "latitude"
      case lon = "longitude"
   }
   
   init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      lat = try values.decode(Double.self, forKey: .lat)
      lon = try values.decode(Double.self, forKey: .lon)
   }
}
