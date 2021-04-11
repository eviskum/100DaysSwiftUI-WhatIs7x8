//
//  ContentView.swift
//  WhatIs7x8
//
//  Created by Esben Viskum on 09/04/2021.
//

import SwiftUI

struct Operators {
    let mul: Bool
    let div: Bool
    let add: Bool
    let sub: Bool
    var mulQuestions: Int
    var divQuestions: Int
    var addQuestions: Int
    var subQuestions: Int
    
    init(mul: Bool, div: Bool, add: Bool, sub: Bool, noOfQuestions: Int) {
        self.mul = mul
        self.div = div
        self.add = add
        self.sub = sub
        mulQuestions = 0
        divQuestions = 0
        addQuestions = 0
        subQuestions = 0
        calcNoOfQuestionsPerOperator(noOfQs: noOfQuestions)
    }
    
    func noOfOperators() -> Int {
        var x: Int = 0
        if mul { x += 1 }
        if div { x += 1 }
        if add { x += 1 }
        if sub { x += 1 }
        return x
    }

    mutating func calcNoOfQuestionsPerOperator(noOfQs: Int) {
        let noOfOps = noOfOperators()
        let noOfQuestionsPerOperator: Int = Int(noOfQs / noOfOps)
        if mul { mulQuestions = noOfQuestionsPerOperator }
        if div { divQuestions = noOfQuestionsPerOperator }
        if add { addQuestions = noOfQuestionsPerOperator }
        if sub { subQuestions = noOfQuestionsPerOperator }
        
        var tempMul: Bool = mul
        var tempDiv: Bool = div
        var tempAdd: Bool = add
        var tempSub: Bool = sub
        
        var remainder = Int(noOfQs / noOfOps)
        while remainder > 0 {
            let randomOp = Int.random(in: 0...3)
            switch randomOp {
            case 0:
                if tempMul {
                    mulQuestions += 1
                    tempMul = false
                    remainder -= 1
                }
            case 1:
                if tempDiv {
                    divQuestions += 1
                    tempDiv = false
                    remainder -= 1
                }
            case 2:
                if tempAdd {
                    addQuestions += 1
                    tempAdd = false
                    remainder -= 1
                }
            default:
                if tempSub {
                    subQuestions += 1
                    tempSub = false
                    remainder -= 1
                }
            }
        }
    }
}

struct Question {
    let question: String
    let answer: Int
    
    init(factor1: Int, factor2: Int) {
        question = String("\(factor1) x \(factor2)")
        answer = factor1 * factor2
    }
}

struct Questions {
    var questions: [Question] = []
    let noQuestions: Int
    let maxFactor: Int
    var answers: [Int] = []
    var correctAnswerIdx = 0
    let eduFactor: Int
    
    init(eduFactor: Int, maxFactor: Int, noQuestions: Int) {
        self.noQuestions = noQuestions
        self.maxFactor = maxFactor
        self.eduFactor = eduFactor
        
        if noQuestions == 0 {
            for i in 0...maxFactor {
                questions.append(Question(factor1: eduFactor, factor2: i))
            }
        } else {
            if noQuestions > maxFactor {
                for i in 0..<noQuestions {
                    if i <= maxFactor {
                        questions.append(Question(factor1: eduFactor, factor2: i))
                    } else {
                        questions.append(Question(factor1: eduFactor, factor2: Int.random(in: 0...maxFactor)))
                    }
                }
            } else {
                for i in 0...maxFactor {
                    questions.append(Question(factor1: eduFactor, factor2: i))
                }
                var j = maxFactor
                while j >= noQuestions {
                    questions.remove(at: Int.random(in: 0...j))
                    j -= 1
                }
            }
        }
        questions.shuffle()
        generateAnswers(activeQuestion: 0)
    }
    
    mutating func generateAnswers(activeQuestion: Int) {
        answers.removeAll()
        answers.append(questions[activeQuestion].answer)
        for i in 0...(maxFactor*eduFactor) {
            if i != answers[0] {
                answers.append(i)
            }
        }
        var j = (maxFactor*eduFactor)
        while j >= 3 {
            answers.remove(at: Int.random(in: 1...j))
            j -= 1
        }
        answers.shuffle()
        for k in 0..<3 {
            if answers[k] == questions[activeQuestion].answer { correctAnswerIdx = k }
        }
        
        print("start...")
        for l in 0..<answers.count {
            print("\(answers[l])")
        }
        
    }
}

struct ContentView: View {
    @State private var userInputScreen = false
    @State private var activeQuestionNo = 0
    @State private var score = 0
    
    var body: some View {
        var questions = Questions(eduFactor: 8, maxFactor: 20, noQuestions: 6)

        Group {
            if userInputScreen {
                // collect startup parameters
            } else {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 30) {
                        Section(header: Text("Din score er...")) {
                            Text("\(score)")
                        }
                        
                        Text(questions.questions[activeQuestionNo].question)
                            .font(.largeTitle)
                            .padding(40)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .onAppear {
                                questions.generateAnswers(activeQuestion: activeQuestionNo)
                            }
                        
                        ForEach(0..<3) { i in
                            Button(action: { print("Trykket på \(i)")}) {
                                Text("\(questions.answers[i])")
                            }
                        }
                        
                        HStack {
                            
                        }
                    }

                }
            }
        }


/*        List {
            ForEach(0..<questions.questions.count) { i in
                Text(questions.questions[i].question)
            }
        }
*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
