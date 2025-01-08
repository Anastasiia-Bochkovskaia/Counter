//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Anastasya Bochkovskaya on 06/01/2025.
//

import Foundation
protocol QuestionFactoryDelegate: AnyObject {               // 1
    func didReceiveNextQuestion(question: QuizQuestion?)    // 2
}
