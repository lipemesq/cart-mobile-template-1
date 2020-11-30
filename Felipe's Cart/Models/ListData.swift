//
//  ListData.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 22/11/20.
//

import Foundation

// No need to use Codable, since I'm not sending data
class RDListData: Decodable {
   let page: Int
   let hasNextPage: Bool
   let items: [ListItem]
   
   enum CodingKeys: String, CodingKey {
      case page
      case hasNextPage = "hasNext"
      case results
      //case items
   }
   
   enum NestedInfo: String, CodingKey {
      case items
   }
   
   required init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      page = try values.decode(Int.self, forKey: .page)
      hasNextPage = try values.decode(Bool.self, forKey: .hasNextPage)
      
      let results = try values.nestedContainer(keyedBy: NestedInfo.self, forKey: .results)
      items = try results.decode([ListItem].self, forKey: .items)
   }
}

class ListItem: Codable {
   let id: String
   let name: String
   let restaurantName: String
   let location: Location
   let prices: [Price]
   let rating: Double
   let tags: [String]
   let image: String?
   
   enum CodingKeys: String, CodingKey {
      case id
      case name
      case restaurantName
      case location
      case prices
      case rating
      case tags
      case image = "photo"
   }
   
   required init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(String.self, forKey: .id)
      name = try values.decode(String.self, forKey: .name)
      restaurantName = try values.decode(String.self, forKey: .restaurantName)
      location = try values.decode(Location.self, forKey: .location)
      prices = try values.decode([Price].self, forKey: .prices)
      rating = try values.decode(Double.self, forKey: .rating)
      tags = try values.decodeIfPresent([String].self, forKey: .tags) ?? []
      image = try values.decodeIfPresent(String.self, forKey: .image)
   }
}

// Amount was aways equal to value, so I'll not complicate things without reason
class Price: Codable {
   let amount: Int
   let currency: Currency
}

struct Currency: Codable {
   let decimalDigits: Int
   let symbol: CurrencySymbol
   let type: CurrencyType
   
   enum CodingKeys: String, CodingKey {
      case decimalDigits = "decimal"
      case symbol
      case type
   }
   
   // the default value will aways be dollar with 2 decimals
   init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      decimalDigits = try values.decodeIfPresent(Int.self, forKey: .decimalDigits) ?? 2
      symbol = try values.decodeIfPresent(CurrencySymbol.self, forKey: .symbol) ?? .dollar
      type = try values.decodeIfPresent(CurrencyType.self, forKey: .type) ?? .usd
   }
}

enum CurrencySymbol: String, Codable {
   case dollar = "$"
}

enum CurrencyType: String, Codable {
   case usd = "USD"
}

enum AvailableFor: String, Codable {
   case catering = "catering"
   case curbside = "curbside"
   case delivery = "delivery"
   case dinein   = "dinein"
   case takeout  = "takeout"
   
   var readable: String {
      switch self {
         case .catering:
            return "Catering"
         case .curbside:
            return "Curbside"
         case .delivery:
            return "Delivery"
         case .dinein:
            return "Dine In"
         case .takeout:
            return "Takeout"
      }
   }
}
