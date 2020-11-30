//
//  ListData.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 22/11/20.
//

import Foundation

// No need to use Codable, since I'm not sending data
class RSListData: Decodable {
   let page: Int
   let hasNextPage: Bool
   let items: [RSListItem]
   
   enum CodingKeys: String, CodingKey {
      case page
      case hasNextPage = "hasNext"
      case results
   }
   
   enum NestedInfo: String, CodingKey {
      case items
   }
   
   required init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      page = try values.decode(Int.self, forKey: .page)
      hasNextPage = try values.decode(Bool.self, forKey: .hasNextPage)
      
      let results = try? values.nestedContainer(keyedBy: NestedInfo.self, forKey: .results)
      guard results != nil else {
         items = []
         return
      }
      items = try results!.decode([RSListItem].self, forKey: .items)
   }
}

class RSListItem: Codable, Identifiable {
   let id: String
   let name: String
   let restaurantName: String
   let location: Location
   let prices: [RSPrice]
   let rating: Double
   let tags: [String]
   let image: String?
   let description: String?
   let availableFor: [RSAvailableFor]
   
   enum CodingKeys: String, CodingKey {
      case id
      case name
      case restaurantName
      case location
      case prices
      case rating
      case tags
      case image = "photo"
      case description
      case availableFor
   }
   
   required init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(String.self, forKey: .id)
      name = try values.decode(String.self, forKey: .name)
      restaurantName = try values.decode(String.self, forKey: .restaurantName)
      location = try values.decode(Location.self, forKey: .location)
      prices = try values.decodeIfPresent([RSPrice].self, forKey: .prices) ?? []
      rating = try values.decode(Double.self, forKey: .rating)
      image = try values.decodeIfPresent(String.self, forKey: .image)
      description = try values.decodeIfPresent(String.self, forKey: .description)
      availableFor = ((try? values.decodeIfPresent([RSAvailableFor].self, forKey: .availableFor) ?? []) ?? [])
         .sorted { (a, b) -> Bool in
            a.readable.lowercased() < b.readable.lowercased()
         }
      
      let _tags = try values.decodeIfPresent([Dictionary<String, String>].self, forKey: .tags) ?? []
      if _tags.isEmpty {
         tags = []
      }
      else {
         tags = _tags.map({$0["name"]!})
      }
   }
}

// Amount was aways equal to value, so I'll not complicate things without reason
class RSPrice: Codable {
   let amount: Int
   let currency: RSCurrency
}

struct RSCurrency: Codable {
   let decimalDigits: Int
   let symbol: RSCurrencySymbol
   let type: RSCurrencyType
   
   enum CodingKeys: String, CodingKey {
      case decimalDigits = "decimal"
      case symbol
      case type
   }
   
   // the default value will aways be dollar with 2 decimals
   init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      decimalDigits = try values.decodeIfPresent(Int.self, forKey: .decimalDigits) ?? 2
      symbol = try values.decodeIfPresent(RSCurrencySymbol.self, forKey: .symbol) ?? .dollar
      type = try values.decodeIfPresent(RSCurrencyType.self, forKey: .type) ?? .usd
   }
}

enum RSCurrencySymbol: String, Codable {
   case dollar = "$"
}

enum RSCurrencyType: String, Codable {
   case usd = "USD"
}

enum RSAvailableFor: String, Codable, Identifiable {   
   case catering = "catering"
   case curbside = "curbside"
   case delivery = "delivery"
   case dinein   = "dine-in"
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
   
   var id: String { rawValue }
}
