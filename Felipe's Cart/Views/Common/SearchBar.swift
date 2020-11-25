//
//  SearchBar.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 24/11/20.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

   let label: String

   @Binding var text: String

   class Coordinator: NSObject, UISearchBarDelegate {

      @Binding var text: String

      let label: String

      init(label: String, text: Binding<String>) {
         self.label = label
         _text = text
      }

      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         text = searchText
      }
   }

   func makeCoordinator() -> SearchBar.Coordinator {
      return Coordinator(label: label, text: $text)
   }

   func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
      let searchBar = UISearchBar(frame: .zero)
      searchBar.delegate = context.coordinator
      searchBar.searchBarStyle = .minimal
      searchBar.placeholder = label
      return searchBar
   }

   func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
      uiView.text = text
   }
}
