//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Anastasya Bochkovskaya on 06/01/2025.
//

import Foundation
struct GameResult {
    let correct: Int
    let total: Int
    let date: Date

    // метод сравнения по количеству верных ответов
    func isBetterThan(_ another: GameResult) -> Bool {
        correct > another.correct
    }
}
protocol StatisticServiceProtocol {
    var gamesCount: Int { get }
    var bestGame: GameResult { get }
    var totalAccuracy: Double { get }
}
