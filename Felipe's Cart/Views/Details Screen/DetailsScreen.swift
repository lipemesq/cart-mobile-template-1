//
//  DetailsScreen.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 22/11/20.
//

import SwiftUI

enum DetailsScreenBuilder {
   static func makeDetailsView(
      of item: RSListItem,
      rsService: RSService
   ) -> some View {
      let controller = DetailsScreenController(
         item: item,
         rsService: rsService
      )
      return LazyView(_DetailsScreen(controller: controller))
   }
}

struct _DetailsScreen: View {
   @ObservedObject var controller: DetailsScreenController
   
   var body: some View {
      Text(controller.item.name)
   }
}

//struct DetailsScreen_Previews: PreviewProvider {
//   static var previews: some View {
//      _DetailsScreen(controller: DetailsScreenController(item: try! JSONDecoder().decode(RSListItem.self, from: Data(RSDataSamples.listData.utf8)), rsService: DefaultRSService()))
//   }
//}
