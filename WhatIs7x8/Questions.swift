//
//  Questions.swift
//  WhatIs7x8
//
//  Created by Esben Viskum on 17/04/2021.
//

import Foundation

struct Question {
    let question: String
    var answers: [Int] = []
    var correctAnswerIdx: Int = 0
    
    init(operation: Operation, level: Level, no1: Int, no2: Int) {
        var answer: Int
        print("Operation \(operation)")
        switch operation {
        case .mul:
            question = String("\(no1) x \(no2)")
            answer = no1 * no2
            generateAnswers(answer: answer, maxResult: Operation.mul.maxAnswer(number: no1, level: level))
        case .div:
            question = String("\(no2*no1) / \(no1)")
            answer = no2
            generateAnswers(answer: answer, maxResult: Operation.div.maxAnswer(number: no1, level: level))
        case .add:
            if no2 > no1 { question = String("\(no2) + \(no1)") }
            else { question = String("\(no1) + \(no2)") }
            answer = no1 + no2
            generateAnswers(answer: answer, maxResult: Operation.add.maxAnswer(number: no1, level: level))
        case .sub:
            if no2 > no1 {
                question = String("\(no2) - \(no1)")
                answer = no2 - no1
            } else {
                question = String("\(no1) - \(no2)")
                answer = no1 - no2
            }
            generateAnswers(answer: answer, maxResult: Operation.sub.maxAnswer(number: no1, level: level))
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
    
    mutating func generateAnswers(answer: Int, maxResult: Int) {
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

        if mul { generateQnA(eduNumber: eduNumber, operation: .mul, level: level, noQuestions: operators.mulQuestions) }
        if div { generateQnA(eduNumber: eduNumber, operation: .div, level: level, noQuestions: operators.divQuestions) }
        if add { generateQnA(eduNumber: eduNumber, operation: .add, level: level, noQuestions: operators.addQuestions) }
        if sub { generateQnA(eduNumber: eduNumber, operation: .sub, level: level, noQuestions: operators.subQuestions) }
        
        questions.shuffle()
    }

    mutating func generateQnA(eduNumber: Int, operation: Operation, level: Level, noQuestions: Int) {
        var maxFactor = 0
        switch (operation) {
        case .mul:
            maxFactor = Operation.mul.maxNumber(level: level)
        case .div:
            maxFactor = Operation.div.maxNumber(level: level)
        case .add:
            maxFactor = Operation.add.maxNumber(level: level)
        case .sub:
            maxFactor = Operation.sub.maxNumber(level: level)
        }

        if noQuestions == 0 {
            for i in 0...maxFactor {
                questions.append(Question(operation: operation, level: level, no1: eduNumber, no2: i))
            }
        } else {
            if noQuestions > maxFactor {
                for i in 0..<noQuestions {
                    if i <= maxFactor {
                        questions.append(Question(operation: operation, level: level, no1: eduNumber, no2: i))
                    } else {
                        questions.append(Question(operation: operation, level: level, no1: eduNumber, no2: Int.random(in: 0...maxFactor)))
                    }
                }
            } else {
                var q: Question
                for _ in 0..<noQuestions {
                    repeat {
                        q = Question(operation: operation, level: level, no1: eduNumber, no2: Int.random(in: 0...maxFactor))
                    } while questions.contains { $0.question == q.question }
                    questions.append(q)
                }
            }
        }
    }
}
