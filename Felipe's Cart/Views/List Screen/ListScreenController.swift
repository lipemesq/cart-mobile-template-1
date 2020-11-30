//
//  ListScreenController.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 20/11/20.
//

import SwiftUI
import Combine
import Moya

class ListScreenController: ObservableObject, Identifiable {
   
   // MARK: - PROPERTIES
   
   // this little one do all the online magical things
   let service: RSService
   let storage: RSStorage = DefaultRSStorage()
   
   @Published var dataStatus: DataRequestStatus = .notYetRequested
   
   @Published var searchedText: String = ""
   
   // result from the api request
   @Published var data: [RSListItem] = []
   
   @Published var hiddenItems: [String] = []
   
   @Published var unhiddenItems: [RSListItem] = []
   
   @Published var currentPage: Int = 0
   
   @Published var hasNextPage: Bool = false
   
   @Published var myError: CustomError = CustomError.unknownError
   
   // for delay in the requests
   private let scheduler: DispatchQueue = DispatchQueue(label: "ListScreenSearchScheduler")
   
   // necessity, keep alive the sinks
   private var observers = Set<AnyCancellable>()
   
   
   // MARK: - INIT
   
   init(rsService: RSService) {
      self.service = rsService
      
      hiddenItems = storage.fetchHiddenItemsIDs()
      
      /// Removed due a bug in swiftUI async operations :(
      /// now done manually
//      $data
//         .dropFirst(1)
//         .sink() { items in
//            // This should be done from the main queue, not from background
//            // (I didn't know that, but adorable xcode taught me)
//            DispatchQueue.main.async {
//               self.unhiddenItems = items.filter({ !self.hiddenItems.contains($0.id) })
//            }
//         }
//         .store(in: &observers)
      
      // do things on every input's change
      $searchedText
         .dropFirst(1) // ignore the OnAppear call
         .debounce(for: .seconds(0.5), scheduler: scheduler)
         .sink() { (text) in
            if text.isEmpty {
               DispatchQueue.main.async {
                  self.dataStatus = .notYetRequested
                  self.data = []
               }
            }
            else {
               self.fetchData(text: text, page: 1)
           }
         }
         .store(in: &observers) // prevent being erased after finishing this init
      
      /// Also removed due a bug in swiftUI async operations :(
      /// now done manually
//      $hiddenItems
//         .sink() { ids in
//            DispatchQueue.main.async {
//               self.unhiddenItems = self.data.filter({ !ids.contains($0.id) })
//            }
//         }
//         .store(in: &observers)
   }
   
   
   // MARK: - MAGIC
   
   /// Make the fetch call
   func fetchData(text: String, page: Int) {
      DispatchQueue.main.async {
         self.dataStatus = .waiting
      }

      service.fetchList(with: text, page: page) { (response) in
         switch response {
            case .success(let result):
               self.currentPage = result.page
               self.hasNextPage = result.hasNextPage
               
               // On first page need to reset the current data
               if result.page == 1 {
                  self.data = result.items
               }
               else {
                  self.data.append(contentsOf: result.items)
               }
               self.unhiddenItems = self.data.filter({ !self.hiddenItems.contains($0.id) })

               self.dataStatus = .done
               print(self.data)
               
            case .failure(let error):
               print(error)
               self.dataStatus = .error
               self.myError = error
               self.data = []
         }
      }
   }
   
   /// Change the data status and make the fetch call for the next page with the current\ searched text
   func loadNextPage() {
      if hasNextPage && dataStatus != .waiting {
         dataStatus = .waiting
         fetchData(text: searchedText, page: currentPage+1)
      }
   }
   
   /// Put the item on an excluded list and update the list
   func hideItem(at offsets: IndexSet) {
      //data.remove(atOffsets: offsets)
      hiddenItems.append(unhiddenItems[offsets.first!].id)
      self.unhiddenItems = self.data.filter({ !self.hiddenItems.contains($0.id) })

      storage.saveHiddenItemsIDs(ids: hiddenItems)
   }
   
   
   // MARK: - NAVIGATION
   
   func getDetailsScreen(item: RSListItem) -> some View {
      return DetailsScreenBuilder
         .makeDetailsView(of: item, rsService: service)
   }
   
   
   // MARK: - VIEW DATA
   
   func pricesText(for item: RSListItem) -> String {
      if item.prices.count == 0 {
         return ""
      }
      else if item.prices.count == 1 {
         let currency = item.prices.first!.currency.symbol.rawValue
         let price = Double(item.prices.first!.amount / 100).string(fractionDigits: 2)
         
         return currency + price
      }
      else {
         let currency = item.prices.first!.currency.symbol.rawValue
         let price = Double(item.prices.first!.amount / 100).string(fractionDigits: 2)
         
         return "from " + currency + price
      }
   }
}
