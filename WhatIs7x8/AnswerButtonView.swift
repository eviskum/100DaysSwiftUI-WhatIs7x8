//
//  AnswerButtonView.swift
//  WhatIs7x8
//
//  Created by Esben Viskum on 17/04/2021.
//

import SwiftUI

struct AnswerGrid<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}
