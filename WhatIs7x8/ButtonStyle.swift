//
//  ButtonStyle.swift
//  WhatIs7x8
//
//  Created by Esben Viskum on 17/04/2021.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

/*
struct AnswerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration, rotationAmount: Double, opacityAmount: Double) -> some View {
        configuration.label
            .frame(width: 75, height: 30)
            .padding(20)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .rotation3DEffect(.degrees(self.rotationAmount[row*2+col]), axis: (x: 0, y: 1, z:0))
            .opacity(self.opacityAmount[row*2+col])
//                            .modifier(Shake(animatableData: CGFloat(self.attempts[row*2+col])))

    }
}

extension Button {
    func answerButtonStyle() -> some View {
        self.buttonStyle(AnswerButtonStyle())
    }
}
*/
struct StartGameButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

extension Button {
    func startGameButton() -> some View {
        self.buttonStyle(StartGameButton())
    }
}
