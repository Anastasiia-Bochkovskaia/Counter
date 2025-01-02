
import UIKit

final class MovieQuizViewController: UIViewController {
    private struct QuizResultsViewModel {
        let title: String
        let text: String
        let buttonText: String
    }

    private struct QuizQuestion {
        let image: String
        let text: String
        let correctAnswer: Bool
    }
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    private let questions: [QuizQuestion] = [
        QuizQuestion(image: "The Godfather", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Dark Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Kill Bill", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Avengers", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Deadpool", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Green Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Old", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "The Ice Age Adventures of Buck Wild", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "Tesla", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "Vivarium", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCurrentQuestion()
    }
    
    private func showCurrentQuestion() {
        let currentQuestion = questions[currentQuestionIndex]
        imageView.image = UIImage(named: currentQuestion.image)
        textLabel.text = currentQuestion.text
        counterLabel.text = "\(currentQuestionIndex + 1)/10"
    }
    
    // приватный метод, который содержит логику перехода в один из сценариев
    private func checkAnswer(isCorrect: Bool) {
        let currentQuestion = questions[currentQuestionIndex]
        if isCorrect == currentQuestion.correctAnswer {
         correctAnswers += 1
        }
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            self.imageView.layer.borderWidth = 0
            showCurrentQuestion()
        } else {
            show(quiz: QuizResultsViewModel(title: "Этот раунд окончен!", text: "Ваш результат: \(correctAnswers)/10", buttonText: "Сыграть ещё раз"))
        }
    }
    
    // приватный метод, который меняет цвет рамки
    private func colorBorder(isCorrect: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.checkAnswer(isCorrect: isCorrect )
        }
    }

    // приватный метод вывода на экран вопроса
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            self.currentQuestionIndex = 0
            self.correctAnswers = 0
            self.imageView.layer.borderWidth = 0
            self.showCurrentQuestion()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction private func yesButtonClicked(_ sender: UIButton) {
            let currentQuestion = questions[currentQuestionIndex] // 1
            let givenAnswer = true // 2
            colorBorder(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        }

        @IBAction private func noButtonClicked(_ sender: UIButton) {
            let currentQuestion = questions[currentQuestionIndex] // 1
            let givenAnswer = false // 2
            colorBorder(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        }
}


