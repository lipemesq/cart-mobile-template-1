//
//  Spoons.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 29/11/20.
//

import SwiftUI

struct Spoons: View {
   let spoons: Int
   let aspectRatio : CGFloat = 82/170
   
   var body: some View {
      HStack (spacing: 5) {
         ForEach(0..<spoons) { i in
            Image("spoon")
               .resizable()
               .aspectRatio(aspectRatio, contentMode: .fit)
               .foregroundColor(CustomColors.red)
         }
         ForEach(spoons..<5) { i in
            Image("spoon")
               .resizable()
               .aspectRatio(aspectRatio, contentMode: .fit)
               .foregroundColor(CustomColors.labelGrey)
         }
      }
      .frame(height: 15)
   }
}

struct Spoons_Previews: PreviewProvider {
   static var previews: some View {
      Spoons(spoons: 3)
   }
}
