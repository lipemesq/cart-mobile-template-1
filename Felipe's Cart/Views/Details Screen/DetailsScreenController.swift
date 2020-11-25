//
//  DetailsScreenController.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 22/11/20.
//

import SwiftUI
import Combine
import Moya

class DetailsScreenController: ObservableObject, Identifiable {
   
   // MARK: - PROPERTIES
   
   // this little one do all the online magical things
   let service: RSService
   
   // the item's id
   let item: RSListItem
   
   // MARK: - INIT
   
   init(item: RSListItem, rsService: RSService) {
      self.item = item
      self.service = rsService
   }
   
   
   // MARK: - MAGIC
   
   func updateData() {
//      service.fetchDetails(for: id) { (response) in
//         switch response {
//            case .success(let result):
//               self.data = result
//            case .failure(_):
//               self.data = ""
//         }
//      }
   }
}
