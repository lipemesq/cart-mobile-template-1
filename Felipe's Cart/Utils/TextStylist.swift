//
//  TextStyle.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 29/11/20.
//

import SwiftUI

// MARK: - MODIFIERS SHORCUTS

extension Text {
   func styleHeadline() -> some View {
      self.modifier(StyleHeadline())
   }
   func styleSubHeadline() -> some View {
      self.modifier(StyleSubHeadline())
   }
   func styleTitle() -> some View {
      self.modifier(StyleTitle())
   }
   func styleBody1() -> some View {
      self.modifier(StyleBody1())
   }
   func styleBody2() -> some View {
      self.modifier(StyleBody2())
   }
   func styleSection() -> some View {
      self.modifier(StyleSection())
   }
   func styleFootnote() -> some View {
      self.modifier(StyleFootnote())
   }
}


// MARK: MODIFIERS

private struct StyleHeadline: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.system(size: 13))
         .lineSpacing(18)
         .foregroundColor(CustomColors.labelBlack)
   }
}

private struct StyleSubHeadline: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.system(size: 13, weight: .light, design: .default))
         .lineSpacing(17)
         .foregroundColor(CustomColors.labelGrey)
   }
}

private struct StyleTitle: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.system(size: 17, weight: .semibold, design: .default))
         .lineSpacing(22)
         .foregroundColor(CustomColors.labelBlack)
   }
}

private struct StyleBody1: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.system(size: 14))
         .lineSpacing(22)
         //.foregroundColor(CustomColors.labelBlack)
   }
}

private struct StyleBody2: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.system(size: 14))
         .lineSpacing(20)
         .foregroundColor(CustomColors.labelGrey)
   }
}

private struct StyleSection: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.system(size: 14, weight: .medium, design: .default))
         .lineSpacing(20)
         .foregroundColor(CustomColors.labelGrey)
   }
}

private struct StyleFootnote: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.system(size: 12))
         .foregroundColor(CustomColors.labelGrey)
   }
}
