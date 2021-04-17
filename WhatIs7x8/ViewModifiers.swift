//
//  ViewModifiers.swift
//  WhatIs7x8
//
//  Created by Esben Viskum on 17/04/2021.
//

import SwiftUI

struct QuestionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding(30)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension Text {
    func questionStyle() -> some View {
        self.modifier(QuestionModifier())
    }
}
