//
//  Spoons.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 29/11/20.
//

import SwiftUI

struct Spoons: View {
   let spoons: Int
   
   var body: some View {
      HStack (spacing: 5) {
         ForEach(0..<spoons) { i in
            Rectangle()
               .fill(Color(.yellow))
               .frame(width: 15, height: 15)
         }
         ForEach(spoons..<5) { i in
            Rectangle()
               .fill(Color(.gray))
               .frame(width: 15, height: 15)
         }
      }
   }
}

struct Spoons_Previews: PreviewProvider {
   static var previews: some View {
      Spoons(spoons: 5)
   }
}
