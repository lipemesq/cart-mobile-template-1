//
//  MoyaErrorToCustomError.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 22/11/20.
//

import Foundation
import Moya

extension CustomError {
   
   /*
    Converting the Moya error to an error that
      a mere mortal student like me knows what it means
    */
   init(moyaError: MoyaError) {
      // in the worst case, i will call ot unkown
      var myself: CustomError = .unknownError
      
      switch moyaError {
         
         // mapping probably its my fault
         case .imageMapping(_), .jsonMapping(_), .stringMapping(_), .objectMapping(_, _), .encodableMapping(_):
            myself = .internalError
            
         // these things should stop at another case, but if they fall here ...
         /// error codes from https://developer.mozilla.org/pt-BR/docs/Web/HTTP/Status
         case .statusCode(let statusCode):
            let error = Int(statusCode.statusCode / 100)
            if error == 3 || error == 5 {
               myself = .serverError
            }
            else if error == 4 {
               myself = .internalError
            }
         
         // these errors were just pushed away by moya, who said: "they don't belong to me!"
         case .underlying(let error, _):
            
            // alamo fire take most of the error to itself
            if let aferror = error.asAFError {
               
               // but, sincerely, i just want to know if it was a network error ;-;
               if let urlerror = aferror.underlyingError as? URLError {
                  switch urlerror.code {
                     
                     // YEEESSSS, FINALLY!!
                     case .timedOut:
                        myself = .timeout
                     case .networkConnectionLost, .notConnectedToInternet:
                        myself = .noConnection
                     default:
                        break
                  }
               }
            }
            
         // probably my fault 2.0
         case .requestMapping(_), .parameterEncoding(_):
            myself = .internalError
      }
      
      self = myself
   }
}
