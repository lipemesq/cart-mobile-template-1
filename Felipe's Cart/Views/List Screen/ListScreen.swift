//
//  ListScreen.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 30/11/20.
//

import SwiftUI

enum ListScreenBuilder {
   static func makeDetailsView(
      rsService: RSService
   ) -> some View {
      let controller = ListScreenController(
         rsService: rsService
      )
      return ListScreen(controller: controller)
   }
}

struct ListScreen: View {
   @ObservedObject var controller: ListScreenController
   
   init(controller: ListScreenController) {
      self.controller = controller
      
      // Setup navigation bar (yes, not cool, swiftUI)
      let appearance = UINavigationBarAppearance()
      appearance.shadowColor = .clear
      appearance.backgroundColor = .white
      
      appearance.backgroundImage = UIImage()
      appearance.shadowImage = UIImage()
      
      UINavigationBar.appearance().tintColor = .red
      
      UINavigationBar.appearance().standardAppearance = appearance
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
   }
   
   var body: some View {
      NavigationView {
         List {
            Section (header: header) {
               
               switch controller.dataStatus {
                  case DataRequestStatus.notYetRequested:
                     goAheadView
                  case DataRequestStatus.done:
                     if controller.data.count > 0 {
                        itemsListView
                     }
                     else {
                        foundNothingView
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
                     if controller.myError == CustomError.internalError {
                        internalErrorView
                     }
                     else if controller.myError == CustomError.noConnection {
                        timeoutErrorView
                     }
                     else  {
                        serverErrorView
                     }
               }
            }
         }
         .listStyle(DefaultListStyle())
         .frame(maxWidth: .infinity)
         .navigationTitle(Text("Top Restaurants"))
         .navigationBarTitleDisplayMode(.automatic)
         .animation(.easeIn)
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
   
   
   // MARK: - IMAGES
   
   var serverErrorView: some View {
      VStack (alignment: .center) {
         Image("error2")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .padding(.bottom, 16)
            .padding(.top, 32)
         
         Text("Err, those guys in the server, they are not working :0")
            .styleBody2()
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
      }
      .frame(maxWidth: .infinity)
      .padding(.bottom, 32)
   }
   
   var timeoutErrorView: some View {
      VStack (alignment: .center) {
         Image("error2")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .padding(.bottom, 16)
            .padding(.top, 32)
         
         Text("Ops, check your network, something is not right...")
            .styleBody2()
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
      }
      .frame(maxWidth: .infinity)
      .padding(.bottom, 32)
   }
   
   var internalErrorView: some View {
      VStack (alignment: .center) {
         Image("error")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .padding(.bottom, 16)
            .padding(.top, 32)
         
         Text("Uhhm, my bad, I just made a mistake and crashed =[")
            .styleBody2()
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
      }
      .frame(maxWidth: .infinity)
      .padding(.bottom, 32)
   }
   
   var goAheadView: some View {
      VStack (alignment: .center) {
         Image("goahead")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .padding(.bottom, 16)
            .padding(.top, 32)
         
         Text("Go ahead, you just have to type some food =]")
            .styleBody2()
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
      }
      .frame(maxWidth: .infinity)
      .padding(.bottom, 32)
   }
   
   var foundNothingView: some View {
      VStack (alignment: .center) {
         Image("nothing")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .padding(.bottom, 16)
            .padding(.top, 32)
         
         Text("So, I found nothing. But you can always try again c:")
            .styleBody2()
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 32)
      }
      .frame(maxWidth: .infinity)
      .padding(.bottom, 32)
   }
   
}

struct ListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen(controller: ListScreenController(rsService: DefaultRSService()))
    }
}
