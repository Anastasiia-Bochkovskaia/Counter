//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Anastasya Bochkovskaya on 06/01/2025.
//

import Foundation
class AlertPresenter {
    let alert = UIAlertController(
        title: result.title,
        message: result.text,
        preferredStyle: .alert)
    
    let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
        guard let self = self else { return }
        self.currentQuestionIndex = 0
        self.correctAnswers = 0
        self.imageView.layer.borderWidth = 0
        self.showCurrentQuestion()
    }
    
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
}
