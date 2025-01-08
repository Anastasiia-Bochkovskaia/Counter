
import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate  {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    private let questionsAmount: Int = 10
    private let questionFactory: QuestionFactoryProtocol = QuestionFactory()
    private var currentQuestion: QuizQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statisticService = StatisticServiceStatisticServiceProtocol() 
        showCurrentQuestion()
        questionFactory = QuestionFactory(delegate: self)

            if let firstQuestion = questionFactory.requestNextQuestion()
    }
    

    private func showCurrentQuestion() {
        guard let question = questionFactory.requestNextQuestion() else {
            return
        }
        
        currentQuestion = question
        imageView.image = UIImage(named: question.image)
        textLabel.text = question.text
        counterLabel.text = "\(currentQuestionIndex + 1)/\(questionsAmount)"
    }
    
    // MARK: - QuestionFactoryDelegate

    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }

        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    
        // приватный метод, который содержит логику перехода в один из сценариев
    
        private func checkAnswer(isCorrect: Bool) {
            guard let question = currentQuestion else {
                return
            }
    
            if isCorrect == question.correctAnswer {
                correctAnswers += 1
            }
    
            currentQuestionIndex += 1
            if currentQuestionIndex < questionsAmount {
                self.imageView.layer.borderWidth = 0
                showCurrentQuestion()
            } else {
                show(quiz: QuizResultsViewModel(title: "Этот раунд окончен!", text: "Ваш результат: \(correctAnswers)/\(questionsAmount)", buttonText: "Сыграть ещё раз"))
            }
        }

        
        // приватный метод, который меняет цвет рамки
    
        private func colorBorder(isCorrect: Bool) {
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 8
            imageView.layer.borderColor = isCorrect ? UIColor.green.cgColor : UIColor.red.cgColor
    
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                self.checkAnswer(isCorrect: isCorrect)
            }
        }

        
        // приватный метод вывода на экран вопроса
        private func show(quiz result: QuizResultsViewModel) {
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
//        @IBAction private func yesButtonClicked(_ sender: UIButton) {
//            guard let currentQuestion = currentQuestion else {
//                return
//            }  // 1
//            let givenAnswer = true // 2
//            colorBorder(isCorrect: givenAnswer == currentQuestion.correctAnswer)
//        }
//        
//        @IBAction private func noButtonClicked(_ sender: UIButton) {
//            guard let currentQuestion = currentQuestion else {
//                return
//            }  // 1
//            let givenAnswer = false // 2
//            colorBorder(isCorrect: givenAnswer == currentQuestion.correctAnswer)
//        }
  //  }
//    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        colorBorder(isCorrect: true)
    }

    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        colorBorder(isCorrect: false)
    }
}
