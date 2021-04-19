//
//  LevelAndOperations.swift
//  WhatIs7x8
//
//  Created by Esben Viskum on 17/04/2021.
//

import Foundation

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
                return 8
            case .hard:
                return 12
            case .expert:
                return 20
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
            return Int(Double(maxNumber(level: level) * number) * 1.2)
        case .div:
            return Int(Double(maxNumber(level: level)) * 1.2)
        case .add:
            return Int(Double(maxNumber(level: level) + number) * 1.2)
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
