//
//  RSRequest.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 20/11/20.
//

import Foundation
import Moya

public enum RSRequest {
   static private let key = "56e379ffa58d2ac1a854abd75b2d76e5fa4b54e551332c83d7c87b3c2fd3caeada916dc330bab3cde7e72114874666cb6e94bd5c6e2b54fd1fbb41a99a9b85d7a3be2e2b1f8e5ba7ed75fbd170d0efaefe61d9b851815771d55048a53ebe34e0"
   
   case list(text: String, page: Int)
   case details(id: String)
}


// MARK: - TARGET TYPE

extension RSRequest: TargetType {
   public var baseURL: URL {
      return URL(string: "https://stg-api.rockspoon.io")!
   }
   
   public var path: String {
      switch self {
         case .list: return "/search/v2/composed"
         case .details(let id): return "/catalog/consumer/item/\(id)"
      }
   }
   
   // 3
   public var method: Moya.Method {
      switch self {
         case .list: return .post
         case .details: return .get
      }
   }
   
   public var sampleData: Data {
      return Data()
   }
   
   public var task: Task {
      switch self {
         case .list(let text, let page):
            let dic : Dictionary<String, Any> = ["term": [text]]
            return .requestParameters(
               parameters: [
                  "entity": "item",
                  "page": page,
                  "size": 10,
                  "params": dic
               ],
               encoding: JSONEncoding.default)
            
         case .details:
            return .requestPlain
      }
   }
   
   public var headers: [String: String]? {
      return [
         "Content-Type": "application/json",
         "key": RSRequest.key
      ]
   }
   
   public var validationType: ValidationType {
      return .successCodes
   }
}
