//
//  ContentView.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 20/11/20.
//

import SwiftUI

struct ContentView: View {
   var body: some View {
      ListScreenBuilder.makeDetailsView(rsService: DefaultRSService())
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
