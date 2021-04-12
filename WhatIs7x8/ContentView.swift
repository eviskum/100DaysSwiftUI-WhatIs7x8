//
//  ContentView.swift
//  WhatIs7x8
//
//  Created by Esben Viskum on 09/04/2021.
//

import SwiftUI

enum Level {
    case easy
    case medium
    case hard
    case expert
}

enum Operation {
    case mul
    case div
    case add
    case sub
    
    func maxNumber(level: Level) -> Int {
        switch (self) {
        case .mul:
            switch (level) {
            case .easy:
                return 5
            case .medium:
                return 10
            case .hard:
                return 20
            case .expert:
                return 50
            }
        case .div:
            switch (level) {
            case .easy:
                return 5
            case .medium:
                return 10
            case .hard:
                return 20
            case .expert:
                return 50
            }
        case .add:
            switch (level) {
            case .easy:
                return 5
            case .medium:
                return 20
            case .hard:
                return 50
            case .expert:
                return 100
            }
        case .sub:
            switch (level) {
            case .easy:
                return 5
            case .medium:
                return 20
            case .hard:
                return 50
            case .expert:
                return 100
            }
        }
    }
    
    func maxAnswer(number: Int, level: Level) -> Int {
        switch (self) {
        case .mul:
            return maxNumber(level: level) * number * 2
        case .div:
            return maxNumber(level: level) * 2
        case .add:
            return (maxNumber(level: level) + number) * 2
        case .sub:
            return maxNumber(level: level) + number
        }
    }
}


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
        
        var remainder = Int(noOfQs % noOfOps)
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
    var answers: [Int] = []
    var correctAnswerIdx: Int = 0
    
    init(operation: Operation, level: Level, no1: Int, no2: Int) {
        var answer: Int
        switch operation {
        case .mul:
            question = String("\(no1) x \(no2)")
            answer = no1 * no2
            generateMulAnswers(answer: answer, maxResult: Operation.mul.maxAnswer(number: no1, level: level))
        case .div:
            question = String("\(no2*no1) / \(no1)")
            answer = no2
            //
        case .add:
            if no2 > no1 { question = String("\(no2) + \(no1)") }
            else { question = String("\(no1) + \(no2)") }
            answer = no1 + no2
            //
        case .sub:
            if no2 > no1 {
                question = String("\(no1) - \(no2)")
                answer = no2 - no1
            } else {
                question = String("\(no1) - \(no2)")
                answer = no1 - no2
            }
            //
        }
        answers.shuffle()
        for k in 0..<4 {
            if answers[k] == answer { correctAnswerIdx = k }
        }
        
        print("start...")
        for l in 0..<answers.count {
            print("\(answers[l])")
        }
    }
    
    mutating func generateMulAnswers(answer: Int, maxResult: Int) {
        answers.append(answer)
        var randomAnswer: Int
        for _ in 1...3 {
            repeat {
                randomAnswer = Int.random(in: 0...maxResult)
            } while answers.contains(randomAnswer)
            answers.append(randomAnswer)
        }
    }
}

struct Questions {
    var questions: [Question] = []
    let noQuestions: Int
    let eduNumber: Int
    
    init(eduNumber: Int, mul: Bool, div: Bool, add: Bool, sub: Bool, level: Level, noQuestions: Int) {
        self.noQuestions = noQuestions
        self.eduNumber = eduNumber
        let operators = Operators(mul: mul, div: div, add: add, sub: sub, noOfQuestions: noQuestions)
        
        if mul { generateMulQnA(eduNumber: eduNumber, level: level, noQuestions: operators.mulQuestions) }
        if div { generateDivQnA(eduNumber: eduNumber, level: level, noQuestions: operators.divQuestions) }
        if add { generateAddQnA(eduNumber: eduNumber, level: level, noQuestions: operators.addQuestions) }
        if sub { generateSubQnA(eduNumber: eduNumber, level: level, noQuestions: operators.subQuestions) }
        
        questions.shuffle()
    }

    mutating func generateMulQnA(eduNumber: Int, level: Level, noQuestions: Int) {
        let maxFactor = Operation.mul.maxNumber(level: level)
        print("maxFactor: \(maxFactor)")
        if noQuestions == 0 {
            for i in 0...maxFactor {
                questions.append(Question(operation: Operation.mul, level: level, no1: eduNumber, no2: i))
            }
        } else {
            if noQuestions > maxFactor {
                for i in 0..<noQuestions {
                    if i <= maxFactor {
                        questions.append(Question(operation: Operation.mul, level: level, no1: eduNumber, no2: i))
                    } else {
                        questions.append(Question(operation: Operation.mul, level: level, no1: eduNumber, no2: Int.random(in: 0...maxFactor)))
                    }
                }
            } else {
                for i in 0...maxFactor {
                    questions.append(Question(operation: Operation.mul, level: level, no1: eduNumber, no2: i))
                }
                var j = maxFactor
                while j >= noQuestions {
                    questions.remove(at: Int.random(in: 0...j))
                    j -= 1
                }
            }
        }
    }

    func generateDivQnA(eduNumber: Int, level: Level, noQuestions: Int) {
    }

    func generateAddQnA(eduNumber: Int, level: Level, noQuestions: Int) {
    }

    func generateSubQnA(eduNumber: Int, level: Level, noQuestions: Int) {
    }

}

struct ContentView: View {
    @State private var userInputScreen = false
    @State private var activeQuestionNo = 0
    @State private var score = 0
    
    var body: some View {
        let questions = Questions(eduNumber: 8, mul: true, div: false, add: false, sub: false, level: .hard, noQuestions: 6)

        Group {
            if userInputScreen {
  //              // collect startup parameters
                Text("Hej")
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
//                                questions.generateAnswers(activeQuestion: activeQuestionNo)
                            }
                        
                        ForEach(0..<4) { i in
                            Button(action: { print("Trykket på \(i)")}) {
                                Text("\(questions.questions[activeQuestionNo].answers[i])")
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
