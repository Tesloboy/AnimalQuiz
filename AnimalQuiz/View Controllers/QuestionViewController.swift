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
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.value = answerCount
        }
    }
    
    // MARK: - IB Outlet Stack View
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var rangedStackView: UIStackView!
    
    // MARK: - IB Outlet содержимого Stack Vie
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var rangeLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    // MARK: - Properties (свойства)
    //Передали экстеншн с вопросами
    private let questions = Question.getQuestions()
    //и добавим индекс
    private var questionIndex = 0
    //после добавления в switch showSingleStackView, получим ответы создав computed property (вычисляемое свойство)
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    //добавм св-во хранящее ответы
    private var answerChosen: [Answer] = []
    
    
    //после создания скрывающей функции создадим переменную
    override func viewDidLoad() {
        super.viewDidLoad() //super т.к вызываем родительский
         updateUI()
    }
    
        // MARK: - ДЗ 1:
    //ДЗ 1: передадим массив с ответами в FinalViewController с помощью segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let FinalViewController = segue.destination as! FinalViewController
            FinalViewController.answerChosenFromQuestion = answerChosen
        }
    }
    // MARK: - Actions
    // Экшены для кнопок ответа
    @IBAction func singleButtonAnswerPressed(_ sender: UIButton) {
        guard let currentIndex = singleButtons.firstIndex(of: sender) else { return }
        
        //выбранный ответ добавим в массив ответов
        let currentAnswer = currentAnswers[currentIndex]
        answerChosen.append(currentAnswer)
        newQuestion()
    }
    
    @IBAction func multipleButtonAnswerPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches,currentAnswers) {
            if multipleSwitch.isOn {
                answerChosen.append(answer)
            }
        }
        
        newQuestion()
    }
    
    @IBAction func rangedButtonAnswerPressed() {
        let index = Int(rangedSlider.value)
        answerChosen.append(currentAnswers[index])
        newQuestion()
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
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        //set progress for progressView (зададим прогресс для progressView)
        progressView.setProgress(totalProgress, animated: true)
        
        //Сделаем так, чтобы конструкция «вопрос - номер» динамически менялась
        //Счет идет с нуля => для КОРРЕКТНОГО отображения номера вопроса прибавляем к индексу единицу
        title = "Вопрос№ \(questionIndex + 1) из \(questions.count)"
        
        
        //вызовем current stackView(после полуения currentAnswers в Properties) Чтобы этот код можно было переиспользовать после for напишем currentQuestion а не singleQuestion
        showCurrentStackView(for: currentQuestion.type)
    }
    
    //Покажем текущий вопрос. Сделаем отдельный метод, который будет отображать StackView. Воспользуемся ранее созданным в enum'e типом ResponsedType делящем вопросы на типы:
    private func showCurrentStackView(for type: ResponsedType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .range:
            showRangeStackView(with: currentAnswers)
        }
    }
    
    //добавим функцию делающую видимой SingleStackView
    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden = false
        
        //пройдемся циклом по кнопкам и соответствующим им ответам и сделаем это одновременно с помощью "zip"
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    //добавим функцию делающую видимой MultipleStackView
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.text
        }
    }
    
    //добавим функцию делающую видимой RangeStackView
        private func showRangeStackView(with answers: [Answer]) {
            rangedStackView.isHidden = false
    
        //т.к у нас 2 лейбла первый и последний, можно без цикла:
            rangeLabels.first?.text = answers.first?.text
            rangeLabels.last?.text = answers.last?.text
        }
    
    private func newQuestion() {
       questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
    
    }

