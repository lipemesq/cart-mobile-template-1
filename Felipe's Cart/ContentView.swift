//
//  ContentView.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 20/11/20.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var controller = ListScreenController(rsService: DefaultRSService())
   
   init() {
      let appearance = UINavigationBarAppearance()
      appearance.shadowColor = .clear
      appearance.backgroundColor = .white
      
      appearance.backgroundImage = UIImage()
      appearance.shadowImage = UIImage()
      
      UINavigationBar.appearance().standardAppearance = appearance
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
   }
   
   var body: some View {
      NavigationView {
         List {
            Section (header: header) {
            
            switch controller.dataStatus {
               case DataRequestStatus.notYetRequested:
                  Text("Digita alguma coisa")
               case DataRequestStatus.done:
                  if controller.unhiddenItems.count > 0 {
                     itemsListView
                  }
                  else {
                     Text("Tem nada")
                  }
               case .waiting:
                  if controller.unhiddenItems.count > 0 {
                     itemsListView
                        .frame(maxWidth: .infinity)
                  }
                  else {
                     loadingView
                  }
               case DataRequestStatus.error:
                  Text("Eita deu erro")
            }
            
            
            bottomListView
            }
         }
//         .listStyle(PlainListStyle())
         .frame(maxWidth: .infinity)
         //.navigationBarTitleDisplayMode(.inline)
         .navigationTitle(Text("Restaurant RockSpoon"))
         //            .toolbar {
         //               ToolbarItem (placement: .navigationBarLeading) {
         //                  Text("Restaurant RockSpoon")
         //                     .font(.title3)
         //                     .padding(.top)
         //               }
         //            }
         .animation(.easeIn)
      }
   }
   
   var itemsListView: some View {
      ForEach(controller.unhiddenItems, id: \.id) { item in
         NavigationLink(destination: controller.getDetailsScreen(item: item)) {
            VStack (alignment: .leading) {
               Text(item.name)
                  .font(.headline)
               
               Text(item.restaurantName)
                  .font(.subheadline)
               
               Text("\(item.rating)")
                  .font(.caption)
            }
            .padding()
         }
      }
      .onDelete { indexSet in
         withAnimation {
            controller.hideItem(at: indexSet)
         }
      }
      .frame(maxWidth: .infinity)
   }
   
   var header: some View {
      VStack (spacing: 0) {
         SearchBar(label: "Procurar", text: $controller.searchedText)
            .padding(.horizontal, 5)
         Divider()
      }
      .background(
         Rectangle()
            .foregroundColor(.white)
            .shadow(color: Color(UIColor.black.withAlphaComponent(0.075)), radius: 6, x: 0, y: 0)
      )
      .padding(.bottom)
      .listRowInsets(EdgeInsets())
   }
   
   /// To be appended at the end of the scroll view.
   /// Under the right conditions, trigger `loadNextPage` on appear
   var bottomListView: some View {
      VStack {
         switch controller.dataStatus {
            case .waiting:
               loadingView
            case .done:
               Rectangle()
                  .onAppear {
                     withAnimation {
                        controller.loadNextPage()
                     }
                  }
            default:
               Rectangle()
         }
      }
   }
   
   var loadingView: some View {
      ProgressView()
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
