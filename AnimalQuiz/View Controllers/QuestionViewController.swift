//
//  QuestionViewController.swift
//  AnimalQuiz
//
//  Created by Viktor Teslenko on 01.03.2023.
//

import UIKit

class QuestionViewController: UIViewController {
    // MARK: - IB Outlet
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var rangedSlider: UISlider!
    // MARK: - IB Outlet Stack View
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var rangedStackView: UIStackView!
    // MARK: - IB Outlet содержимого Stack View
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var rangeLabels: [UILabel]!
    
    // MARK: - Properties (свойства)
    //добавим ссылку на экстеншн с вопросами
    private let questions = Question.getQuestiobns()
    //и добавим индекс
    private var questionIndex = 0
    //после добавления в switch showSingleStackView, получим ответы создавв computed property (вычисляемое свойство)
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    //после создания скрывающей функции создадим переменную
    override func viewDidLoad() {
        super.viewDidLoad() //super т.к вызываем родительский
         updateUI()
    }
}
    // MARK: - private
    // Cоздадим экстеншн с приватными методами
extension QuestionViewController {
    private func updateUI () {
        //Hide stacks. Т.к сейчас все вопросы наслаиваются друг на друга, а в процессе использования приложения пользователь не будет их скрывать с помощью кнопки instalt, добавим цикл чтобы их скрыть:
        for stackView in [ singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
            //поднимемся выше и в классе создадим переменную во viewDidLoad и вызовем ее
        }
        
        //get current question(возьмем текущий вопрос)
        let currentQuestion = questions[questionIndex]
        
        //set current question for label (взаимосвязь между описанием и текущей позицией вопроса)
        questionLabel.text = currentQuestion.text
        
        //сalculate progress(посчитаем прогресс)
        let totalProgress = (Float(questionIndex) / Float(questions.count))
        
        //set progress for progressView (зададим прогресс для progressView)
        progressView.setProgress(totalProgress, animated: true)
        
        //Сделаем так, чтобы конструкция «вопрос - номер» динамически менялась
        //Счет идет с нуля => для КОРРЕКТНОГО отображения номера вопроса прибавляем к индексу единицу
        title = "Вопрос№ \(questionIndex + 1) из \(questions.count)"
        
        
        //вызовем current stackView(после полуения currentAnswers в Properties)
        //Чтобы этот код можно было переиспользовать после for напишем currentQuestion а не singleQuestion
        showCurrentStackView(for: currentQuestion.type)
    }
    
    //Покажем текущий вопрос. Сделаем отдельный метод, который будет отображать StackView. Воспользуемся ранее созданным в enum'e типом ResponsedType делящем вопросы на типы:
    private func showCurrentStackView(for  type: ResponsedType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            break
        case .range:
            break
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden = false
    
        //пройдемся циклом по кнопкам и соответствующим им ответам и сделаем это одновременно с помощью "zip"
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
}

