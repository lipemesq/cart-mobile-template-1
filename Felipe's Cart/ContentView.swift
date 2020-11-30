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
            }
         }
         .listStyle(DefaultListStyle())
         .frame(maxWidth: .infinity)
         .navigationTitle(Text("Top Restaurants"))
         //.listStyle(PlainListStyle())
         //         .navigationBarTitleDisplayMode(.inline)
         //         .toolbar {
         //            ToolbarItem (placement: .navigationBarLeading) {
         //               Text("Restaurant RockSpoon")
         //                  .font(.title3)
         //                  .padding(.top)
         //            }
         //         }
         .animation(.easeIn)
      }
      .onAppear {
         #if DEBUG
         //controller.dataStatus = .done
         //controller.data = try! JSONDecoder().decode([RSListItem].self, from: Data(RSDataSamples.listData.utf8))
         #endif
      }
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
      .listRowInsets(EdgeInsets())
   }
   
   var itemsListView: some View {
      ForEach(controller.unhiddenItems, id: \.id) { item in
         let pricesText = controller.pricesText(for: item)
         
         // To hide the small indicator
         ZStack {
            HStack (alignment: .top, spacing: 0) {
               VStack (alignment: .leading, spacing: 0) {
                  Text(item.name)
                     .styleHeadline()
                     .lineLimit(2)
                     .padding(.bottom, 4)
                  
                  Spoons(spoons: Int(item.rating))
                     .padding(.bottom, 8)
                  
                  Text(item.description ?? "No description")
                     .styleSubHeadline()
                     .lineLimit(2)
                     .padding(.bottom, 8)
                  
                  if !pricesText.isEmpty {
                     Text(pricesText)
                        .styleHeadline()
                  }
               }
               
               Spacer()
               
               CachedImageView(urlString: item.image)
                  .frame(width: 74, height: 74)
                  .background(Color(.blue))
            }
            
            NavigationLink(destination: controller.getDetailsScreen(item: item)) {
               EmptyView()
            }
            // To hide the small indicator
            .hidden()
            
            // If this item is the last, in the it appears it should call for more
            .onAppear() {
               if item.id == controller.unhiddenItems.last?.id {
                  withAnimation {
                     controller.loadNextPage()
                  }
               }
            }
         }
      }
      
      // On swipe left
      .onDelete { indexSet in
         withAnimation {
            controller.hideItem(at: indexSet)
         }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 16)
      .padding(.top, 16)
      .padding(.bottom, 8)
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
