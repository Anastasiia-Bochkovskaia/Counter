//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Anastasya Bochkovskaya on 06/01/2025.
//

import Foundation
final class StatisticService {
    private let storage: UserDefaults = .standard
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
}

// или реализуем протокол с помощью расширения
extension StatisticService: StatisticServiceProtocol {
    var totalAccuracy: Double {
        "\(String(format: "%.2f", statisticService.totalAccuracy))%" 
        
    }
    var bestGame: GameResult {
        get {
            // Добавьте чтение значений полей GameResult(correct, total и date) из UserDefaults,
            // затем создайте GameResult от полученных значений
        }
        set {
            // Добавьте запись значений каждого поля из newValue из UserDefaults
        }
    } 
    }
    func store(correct count: Int, total amount: Int) {
        
    }
}
private enum Keys: String {
    case correct
    case bestGame
    case gamesCount
}
class StatisticServiceImplementation: StatisticServiceProtocol {
    
}
