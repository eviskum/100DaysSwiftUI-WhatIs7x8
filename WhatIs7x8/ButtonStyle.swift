//
//  ButtonStyle.swift
//  WhatIs7x8
//
//  Created by Esben Viskum on 17/04/2021.
//

import SwiftUI

struct AnswerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 75, height: 30)
            .padding(20)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
    }
}

extension Button {
    func answerButtonStyle() -> some View {
        self.buttonStyle(AnswerButtonStyle())
    }
}

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
