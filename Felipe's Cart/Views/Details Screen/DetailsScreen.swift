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
   
   let columns = [
      GridItem(.flexible()),
      GridItem(.fixed(30)),
   ]
   
   var body: some View {
      let pricesText = controller.pricesText()
            
      List {
         VStack (alignment: .leading, spacing: 0) {
            Text(controller.item.name)
               .styleTitle()
               .padding(.bottom, 8)
            
            Text(controller.item.description ?? "No description")
               .styleBody2()
               .padding(.bottom, 16)
            
            if !pricesText.isEmpty {
               Text(pricesText)
                  .styleBody1()
                  .padding(.bottom, 8)
            }
         }
         
         tagsList
         
         availabilitySection
         
         Section(header: locationHeader) {
            VStack(alignment: .leading, spacing: 0) {
               Text(controller.item.restaurantName)
                  .styleBody1()
                  .padding(.bottom, 4)
               
               Text(controller.locationName)
                  .styleFootnote()
                  .lineLimit(2)
            }
            .padding(.vertical, 8)
         }
         .textCase(nil)
      }
   }
   
   var tagsList: some View {
      let tags = controller.getTags()
      
      return ScrollView (.horizontal, showsIndicators: false) {
         HStack (spacing: 8) {
            ForEach(tags, id: \.self) { tag in
               Text(tag)
                  .font(.system(size: 12))
                  .foregroundColor(.white)
                  .padding(.horizontal, 14)
                  .padding(.vertical, 4)
                  .background(
                     RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.red))
                  )
            }
         }
      }
      .padding(.vertical, 8)
   }
   
   var sizesHeader: some View {
      VStack {
         Spacer()
         Text("Sizes")
            .styleSection()
            .padding(.bottom, 4)
      }
      .frame(height: 60)
   }
   
   var availabilityHeader: some View {
      VStack {
         Spacer()
         Text("Available for")
            .styleSection()
            .padding(.bottom, 4)
      }
      .frame(height: 60)
   }
   
   var availabilitySection: some View {
      let availablesFirstHalf = Int((Double(controller.item.availableFor.count) / 2.0).rounded(.up))
      let availablesLastHalf = controller.item.availableFor.count - availablesFirstHalf

      return Section(header: availabilityHeader) {
         HStack (alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
               ForEach(controller.item.availableFor.prefix(availablesFirstHalf)) { av in
                  Text(av.readable)
                     .styleBody1()
               }
            }
            .padding(.trailing, 16)
            
            VStack(alignment: .leading, spacing: 8) {
               ForEach(controller.item.availableFor.prefix(availablesFirstHalf)) { av in
                  Text("✓")
                     .styleBody1()
                     .foregroundColor(.red)
               }
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
               ForEach(controller.item.availableFor.suffix(availablesLastHalf)) { av in
                  HStack (spacing: 8) {
                     Text(av.readable)
                        .styleBody1()
                  }
               }
            }
            .padding(.trailing, 16)
            
            VStack(alignment: .leading, spacing: 8) {
               ForEach(controller.item.availableFor.suffix(availablesLastHalf)) { av in
                  Text("✓")
                     .styleBody1()
                     .foregroundColor(.red)
               }
            }
            
            Spacer()
         }
         .padding(.vertical, 8)
      }
      .textCase(nil)
   }
   
   var locationHeader: some View {
      VStack {
         Spacer()
         Text("Restaurant location")
            .styleSection()
            .padding(.bottom, 4)
      }
      .frame(height: 60)
   }
}

let testItem = try! JSONDecoder().decode([RSListItem].self, from: Data(RSDataSamples.listData.utf8)).first!

struct DetailsScreen_Previews: PreviewProvider {
   static var previews: some View {
      _DetailsScreen(controller: DetailsScreenController(item: testItem, rsService: DefaultRSService()))
   }
}
