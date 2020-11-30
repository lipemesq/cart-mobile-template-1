//
//  StringFromFractionalDigits.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 29/11/20.
//

import Foundation

extension Float {
   func string(fractionDigits:Int) -> String {
      let formatter = NumberFormatter()
      formatter.minimumFractionDigits = fractionDigits
      formatter.maximumFractionDigits = fractionDigits
      return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
   }
}

extension Double {
   func string(fractionDigits:Int) -> String {
      let formatter = NumberFormatter()
      formatter.minimumFractionDigits = fractionDigits
      formatter.maximumFractionDigits = fractionDigits
      return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
   }
}
