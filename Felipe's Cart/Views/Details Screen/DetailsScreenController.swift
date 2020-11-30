//
//  DetailsScreenController.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 22/11/20.
//

import SwiftUI
import Combine
import Moya
import CoreLocation

class DetailsScreenController: ObservableObject, Identifiable {
   
   // MARK: - PROPERTIES
   
   // this little one do all the online magical things
   let service: RSService
   
   // the item's id
   let item: RSListItem
   
   @Published var locationName: String = ""
   
   // MARK: - INIT
   
   init(item: RSListItem, rsService: RSService) {
      self.item = item
      self.service = rsService
      
      getPlace()
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
   
   func getPlace() {
      let location = CLLocation(latitude: item.location.lat, longitude: item.location.lon)
      let geocoder = CLGeocoder()
      geocoder.reverseGeocodeLocation(location) { placemarks, error in
         
         guard error == nil else {
            print("*** Error in \(#function): \(error!.localizedDescription)")
            self.locationName = ""
            return
         }
         
         guard let placemark = placemarks?[0] else {
            print("*** Error in \(#function): placemark is nil")
            self.locationName = ""
            return
         }
         
         var output = ""
         if let street = placemark.subThoroughfare {
            output += "\(street)"
         }
         if let town = placemark.locality {
            output += ", \(town)"
         }
         if let state = placemark.administrativeArea {
            output += ", \(state)"
         }
         if let country = placemark.country {
            output += " - \(country)"
         }
         
         self.locationName = output
      }
   }
   
   
   // MARK: - VIEW DATA
   
   func pricesText() -> String {
      if item.prices.count == 0 {
         return ""
      }
      else if item.prices.count == 1 {
         let currency = item.prices.first!.currency.symbol.rawValue
         let price = Double(item.prices.first!.amount / 100).string(fractionDigits: 2)
         
         return currency + price
      }
      else {
         let currency = item.prices.first!.currency.symbol.rawValue
         let price = Double(item.prices.first!.amount / 100).string(fractionDigits: 2)
         
         return "from" + currency + price
      }
   }
   
   func getTags() -> [String] {
      var validTags : [String] = []
      item.tags.forEach { (tag) in
         let split = tag.split(separator: ">")
         
         if split.count > 1 {
            let last = split.last
            if !(last?.isEmpty ?? true) {
               validTags.append(String(last!))
            }
         }
      }
      
      return validTags
   }
}
