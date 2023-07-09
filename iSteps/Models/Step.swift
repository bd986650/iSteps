//
//  Step.swift
//  iSteps
//
//  Created by Данил Белов on 06.07.2023.
//

import Foundation

struct Step: Identifiable {
    let id = UUID().uuidString
    let count: Int
    let date: Date
}
