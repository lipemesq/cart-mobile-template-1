//
//  CachedImage.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 29/11/20.
//

// Learned from this tutorial: https://schwiftyui.com/swiftui/downloading-and-caching-images-in-swiftui/

import SwiftUI

struct CachedImageView: View {
   @ObservedObject var controller: CachedImageController
   
   init(urlString: String?) {
      controller = CachedImageController(urlString: urlString)
   }
   
   var body: some View {
      if controller.dataStatus == .done {
         Image(uiImage: controller.image ?? CachedImageView.placeholderImage)
            .resizable()
            .scaledToFit()
      }
      else if controller.dataStatus == .waiting {
         ProgressView()
      }
      else if controller.dataStatus == .error {
         Image(uiImage: CachedImageView.errorImage)
            .resizable()
            .scaledToFit()
      }
      else {
         Image(uiImage: CachedImageView.placeholderImage)
            .resizable()
            .scaledToFit()
      }
      
//      Image(uiImage: controller.image ?? CachedImageView.errorImage)
//         .resizable()
//         .scaledToFit()
//         .frame(width: 100, height: 100)
   }
   
   static var placeholderImage = UIImage(named: "placeholderImage")!
   static var errorImage = UIImage(named: "errorImage")!
}

class CachedImageController: ObservableObject {
   @Published var image: UIImage?
   @Published var dataStatus: DataRequestStatus = DataRequestStatus.notYetRequested
   
   var urlString: String?
   var imageCache = ImageCache.getImageCache()
   
   init(urlString: String?) {
      self.urlString = urlString
      loadImage()
   }
   
   /// Load a image, from cache if available or from net otherwise
   func loadImage() {
      dataStatus = .waiting
      if loadImageFromCache() {
         dataStatus = .done
         return
      }
      loadImageFromUrl()
   }
   
   func loadImageFromCache() -> Bool {
      guard let urlString = urlString else {
         dataStatus = .error
         return false
      }
      
      guard let cacheImage = imageCache.get(forKey: urlString) else {
         return false
      }
      
      image = cacheImage
      return true
   }
   
   /// make the http call and delegate the result to `getImageFromResponse`
   func loadImageFromUrl() {
      guard let urlString = urlString else {
         return
      }
      
      let url = URL(string: urlString)!
      let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
      task.resume()
   }
   
   /// Handle the result from the http call
   func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
      guard error == nil else {
         print("Error: \(error!)")
         dataStatus = .error
         return
      }
      guard let data = data else {
         print("No data found")
         dataStatus = .error
         return
      }
      
      DispatchQueue.main.async {
         guard let loadedImage = UIImage(data: data) else {
            self.dataStatus = .error
            return
         }
         
         self.imageCache.set(forKey: self.urlString!, image: loadedImage)
         self.image = loadedImage
         self.dataStatus = .done
      }
   }
}
