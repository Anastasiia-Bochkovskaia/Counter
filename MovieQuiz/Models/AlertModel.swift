//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Anastasya Bochkovskaya on 06/01/2025.
//

import Foundation
struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: ((Bool) -> Void)
}
