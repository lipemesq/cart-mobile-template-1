//
//  ImageCache.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 29/11/20.
//

// Learned from this tutorial: https://schwiftyui.com/swiftui/downloading-and-caching-images-in-swiftui/

import UIKit

class ImageCache {
   var cache = NSCache<NSString, UIImage>()
   
   func get(forKey: String) -> UIImage? {
      return cache.object(forKey: NSString(string: forKey))
   }
   
   func set(forKey: String, image: UIImage) {
      cache.setObject(image, forKey: NSString(string: forKey))
   }
}

extension ImageCache {
   private static var imageCache = ImageCache()
   static func getImageCache() -> ImageCache {
      return imageCache
   }
}
