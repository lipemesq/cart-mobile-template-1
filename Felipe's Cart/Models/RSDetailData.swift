//
//  RLDetailData.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 24/11/20.
//

import Foundation

/**
 The only thing used in this API call is the "sizes" parameter, and it was null in all 30 calls I made, so I won't be spending time doing it.
 If you. for some reason, want to evaluate how I would make an API call or a data model, I ask you to look at RSListData.
*/
class RSDetailData: Decodable {
   let sizesAndPrices: [RSSizeAndPrice]
}

class RSSizeAndPrice: Decodable, Identifiable {
   let id = UUID()
   let sizeName: String
   let price: Double
   
   enum CodingKeys: String, CodingKey {
      case sizeName = "name"
      case menuAttributes
   }
   
   enum MenuKeys: String, CodingKey {
      case price
   }
   
   required init(from decoder: Decoder) throws {
      let bundle = try decoder.container(keyedBy: CodingKeys.self)
      var size = try bundle.decodeIfPresent(String.self, forKey: .sizeName) ?? "Medium"
      if size == "SINGLE_PRICE" {
         size = "Medium"
      }
      sizeName = size
      
      //let menuPrices = try bundle.nestedContainer(keyedBy: MenuKeys.self, forKey: .menuAttributes)
      let menuPrices = try bundle.decodeIfPresent([RSMenu].self, forKey: .menuAttributes) ?? []
      if menuPrices.count > 0 {
         price = menuPrices.first!.price
      }
      else {
         price = 0
      }
   }
}

fileprivate class RSMenu: Decodable {
   let price: Double
}
