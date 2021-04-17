//
//  ContentView.swift
//  WhatIs7x8
//
//  Created by Esben Viskum on 09/04/2021.
//

import SwiftUI


var questions = Questions(eduNumber: 1, mul: true, div: false, add: false, sub: false, level: .easy, noQuestions: 5)

struct ContentView: View {
    @State private var userInputScreen = true
    @State private var activeQuestionNo = 0
    @State private var score = 0
    @State private var eduNumber = 5
    @State private var mul = true
    @State private var div = true
    @State private var add = true
    @State private var sub = true
    @State private var levelIdx = 0
    @State private var noOfQuestionsIdx = 0

    var body: some View {
        let levelText = ["Let", "Middel", "Svær", "Ekspert"]
        let questionsText = ["10", "25", "50", "Alle"]

        Group {
            if userInputScreen {
                NavigationView {
                    VStack {
                        Form {
                            Section(header: Text("Vælg øvelsestal")) {
                                Picker(selection: $eduNumber, label: Text("Vælg øvelsestal")) {
                                    ForEach(0..<51) {i in
                                        Text("\(i)")
                                    }
                                }
                            }
                            
                            Section(header: Text("Vælg regnearter")) {
                                Toggle("x  gange", isOn: $mul)
                                Toggle("/  divider", isOn: $div)
                                Toggle("+  plus", isOn: $add)
                                Toggle("-  minus", isOn: $sub)
                            }
                            
                            Section(header: Text("Vælg sværhed")) {
                                Picker("Sværhed", selection: $levelIdx) {
                                    ForEach(0..<levelText.count) { i in
                                        Text("\(levelText[i])")
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }

                            Section(header: Text("Vælg antal spørgsmål")) {
                                Picker("Antal spørgsmål", selection: $noOfQuestionsIdx) {
                                    ForEach(0..<questionsText.count) { j in
                                        Text("\(questionsText[j])")
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button("Start spil") {
                            startGame()
                        }
                        .startGameButton()
                        
                        Spacer()
                            .frame(height: 20)
                    }
                    .navigationBarTitle("Træn matematik")
                }
            } else {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 30) {
                        Text("Din score er: \(score)")
                            .font(.largeTitle)
                        
                        Text(questions.questions[activeQuestionNo].question)
                            .questionStyle()

                        AnswerGrid(rows: 2, columns: 2) { row, col in
                            Button(action: { answerAction(i: row*2+col) }) {
                                Text("\(questions.questions[activeQuestionNo].answers[row*2+col])")
                                    .font(.title)
                            }
                            .answerButtonStyle()
                        }
                    }
                }
            }
        }
    }
    
    func startGame() {
        var level: Level
        switch (levelIdx) {
        case 0:
            level = Level.easy
        case 1:
            level = Level.medium
        case 2:
            level = Level.hard
        default:
            level = Level.expert
        }
        var noOfQuestions: Int
        switch (noOfQuestionsIdx) {
        case 0:
            noOfQuestions = 10
        case 1:
            noOfQuestions = 25
        case 2:
            noOfQuestions = 50
        default:
            noOfQuestions = 0
        }
        questions = Questions(eduNumber: eduNumber, mul: mul, div: div, add: add, sub: sub, level: level, noQuestions: noOfQuestions)
        activeQuestionNo = 0
        score = 0
        userInputScreen = false
    }
    
    func answerAction(i: Int) {
        if i == questions.questions[activeQuestionNo].correctAnswerIdx { score += 1 }
        activeQuestionNo += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
