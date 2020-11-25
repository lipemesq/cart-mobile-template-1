//
//  LazyView.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 22/11/20.
//

import SwiftUI

// For NavigationLink, because sometimes apple just seems to hate we developers
// taken from https://stackoverflow.com/questions/57594159/swiftui-navigationlink-loads-destination-view-immediately-without-clicking
// works just fine

struct LazyView<Content: View>: View {
   let build: () -> Content
   init(_ build: @autoclosure @escaping () -> Content) {
      self.build = build
   }
   var body: Content {
      build()
   }
}
