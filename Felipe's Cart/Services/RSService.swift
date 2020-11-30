//
//  RSService.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 20/11/20.
//

import Foundation
import Moya
import SwiftUI

protocol RSService {
   func fetchList(with text: String, page: Int, completion: @escaping (Result<RSListData, CustomError>) -> Void)
   func fetchDetails(for id: String, completion: @escaping (Result<String, CustomError>) -> Void)
}

// MARK: - DEFAULT IMPLEMENTATION

class DefaultRSService : RSService {
   let provider = MoyaProvider<RSRequest>()
   
   var listSubscription: Cancellable?
   var detailSubscription: Cancellable?
   
   func fetchList(with text: String, page: Int, completion: @escaping (Result<RSListData, CustomError>) -> Void) {
      
      // Cancel the current request
      if let currentSub = listSubscription {
         // I do prefer [== false] instead of [!] because is easier to read
         // and the compiler will optimize it anyway
         if currentSub.isCancelled == false {
            currentSub.cancel()
         }
      }
      
      listSubscription = provider.request(.list(text: text, page: page)) { (response) in
         switch response {
            case .success(let response):
               do {
                  let data = try JSONDecoder().decode(RSListData.self, from: response.data)
                  completion(.success(data))
               } catch {
                  print(error)
                  completion(.failure(.internalError))
               }
            case .failure(let error):
               print(error)
               // omg, I'm so proud of this thing *-*
               completion(.failure(.init(moyaError: error)))
         }
      }
   }
   
   func fetchDetails(for id: String, completion: @escaping (Result<String, CustomError>) -> Void) {
      
      // Cancel the current request
      if let currentSub = detailSubscription {
         if currentSub.isCancelled == false {
            currentSub.cancel()
         }
      }
      
      detailSubscription = provider.request(.details(id: id)) { (response) in
         switch response {
            case .success(let response):
               completion(.success(response.data.description))
            case .failure(let error):
               print(error)
               // omg, I'm so proud of this thing *-*
               completion(.failure(.init(moyaError: error)))
         }
      }
   }
}
