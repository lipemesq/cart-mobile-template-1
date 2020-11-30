//
//  RSUserDefaults.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 23/11/20.
//

import Foundation

protocol RSStorage {
   func fetchHiddenItemsIDs() -> [String]
   func saveHiddenItemsIDs(ids: [String])
}

class DefaultRSStorage: RSStorage {
   private let defaults = UserDefaults.standard
   
   let hiddenItemsTag = "hidden_3"

   func saveHiddenItemsIDs(ids: [String]) {
      defaults.setValue(ids, forKey: hiddenItemsTag)
   }
   
   func fetchHiddenItemsIDs() -> [String] {
      return (defaults.value(forKey: hiddenItemsTag) as? [String]) ?? []
   }
}
