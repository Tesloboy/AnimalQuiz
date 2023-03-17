//
//  FinalViewController.swift
//  AnimalQuiz
//
//  Created by Viktor Teslenko on 01.03.2023.
//

import UIKit

class FinalViewController: UIViewController {
    
    // MARK: - ДЗ
    // 1. Передать сюда массив с ответами
    // 2. Определить наиболее часто встречающееся животное (есть chosenAnswers и Answer хранит в себе тип животного и текст => нужно пройтись по массиву(создав дикшнри или что то подобное) и просуммировать количество животных и выбрать наиболее часто втречающееся)
    // 3. Отобразить результаты на экране
    // 4. Избавиться от кнопки возврата на предыдущий экран
    
    // MARK: - IB Outlets
    @IBOutlet var finalLabel: UILabel!
    @IBOutlet var finalDescription: UILabel!
    
    // MARK: - Переменные
    //ДЗ 1: объявим массив с ответами переданный из QuestionViewController
    var answerChosenFromQuestion = [Answer]()
    
    //ДЗ 2: создадим СЛОВАРЬ для подсчета ответов
    var finalAnswersCount = [AnimalType: Int]()
    
    //ДЗ 2: добавим переменную с наибольшим количеством типов животных
    var mostFrequentType: AnimalType = .dog
    //ДЗ 2: добавим переменную с количсетвом раз которые мы выбирали животное
    var maxCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - подсчет ответов
        
        //ДЗ 2:  Подсчет ответов с помощью switch: Пройдемся по каждому элементу массива answerChosenFromQuestion
        for someAnswer in answerChosenFromQuestion {
            //ДЗ 2: проверяем тип ответа и увеличиваем соответствующий счетчик в словаре
            switch someAnswer.type {
            case .dog:
                finalAnswersCount[.dog, default: 0] += 1
            case .cat:
                finalAnswersCount[.cat, default: 0] += 1
            case .rabbit:
                finalAnswersCount[.rabbit, default: 0] += 1
            case .turtle:
                finalAnswersCount[.turtle, default: 0] += 1
            }
            
        }
        
        // MARK: - отбор наиболее встречающегося ответа
        //ДЗ 2: Для того чтобы посчитать количество животных каждого типа и выбрать наиболее часто встречающиеся, можно воспользоваться словарем finalAnswersCount, который мы использовали для подсчета количества ответов каждого типа и пройтись по нему циклом чтобы найти наиболее часто встречающийся тип животного:
        
                for (type, count) in finalAnswersCount {
                    if count > maxCount {
                        mostFrequentType = type
                        maxCount = count
                    }
                }
        
        // MARK: - вывод ответа на экран
        //ДЗ 3: Выводим наиболее часто встречающийся тип животного на экран
        finalLabel.text = "Вы - \(mostFrequentType.rawValue)!"
        finalDescription.text = "\(mostFrequentType.definition)"
        
        //ДЗ 4: Скроем кнопку "Back"
        navigationItem.hidesBackButton = true
    }
}

