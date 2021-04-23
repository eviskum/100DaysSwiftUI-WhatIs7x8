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
            .frame(width: 170, height: 30)
            .font(.largeTitle)
            .padding(30)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 2))
    }
}

extension Text {
    func questionStyle() -> some View {
        self.modifier(QuestionModifier())
    }
}

struct AnswerModifier: ViewModifier {
    var rotationAmount: Double
    var opacityAmount: Double
    var attempts:Int
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .frame(width: 75, height: 30)
            .padding(20)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
//            .rotation3DEffect(.degrees(self.rotationAmount[row*2+col]), axis: (x: 0, y: 1, z:0))
//            .opacity(self.opacityAmount[row*2+col])
//            .modifier(Shake(animatableData: CGFloat(self.attempts[row*2+col])))
            .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0, y: 1, z:0))
            .opacity(opacityAmount)
            .modifier(Shake(animatableData: CGFloat(attempts)))
    }
}

extension Text {
    func answerStyle(rotationAmount: Double, opacityAmount: Double, attempts: Int) -> some View {
        self.modifier(AnswerModifier(rotationAmount: rotationAmount, opacityAmount: opacityAmount, attempts: attempts))
    }
}
