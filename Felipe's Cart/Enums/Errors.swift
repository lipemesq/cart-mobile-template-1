//
//  Errors.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 22/11/20.
//

import Foundation

enum CustomError : Error {
   case internalError
   case serverError
   case unknownError
   case timeout
   case noConnection
}
