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



////РЕШЕНИЕ ОТ ПРЕПОДА:
////КОД ВСЕЙ СТРАНИЦЫ:
//
//import UIKit
//
//class ResultsViewController: UIViewController {
//
//    @IBOutlet var animalTypeLabel: UILabel!
//    @IBOutlet var descriptionLabel: UILabel!
//
//    var answers: [Answer]!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        navigationItem.hidesBackButton = true
//
//        //объявим переменные из 3 спооба
//        let maxAnimal = getMaxAnimal()
//        //добавим в UI
//        updateUI(with: maxAnimal)
//    }
//}
//
//// MARK: - Private Methods
//extension ResultsViewController {
//
//    //способ 3 перенесем сразу сюда для возможности его альтернативного использования
//    private func getMaxAnimal() -> AnimalType? {
//        return Dictionary(grouping: answers, by: { $0.type })
//            .sorted(by: {$0.value.count > $1.value.count})
//            .first?.key
//    }
//
//    private func updateResult() {
//
////        //добавим переменные для первых 2-х способов:
////        // словарь где ключ-типживотного, значение-количество раз его выбора
////        var frequencyOfAnimals: [AnimalType: Int] = [:]
////        //У нас был словарь, НЕ итерируемый список, соответственно нам нужно его ЗАИТЕРИРОВАТЬ. Методом .map сделаем список животных. Т.е взяли ответы и тип значения type преобразовали в AnimalType
////        let animals = answers.map { $0.type }
//
//
//         //Пройдемся циклом по списку. Если словарь содержит по ключу животное, ДОБАВЛЯЕМ в значение 1, если значения по ключу нет (nil) то значением будет "1"
//
////        //способ 1:
////        for animal in animals {
////            if let animalTypeCount = frequencyOfAnimals[animal] {
////                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
////            } else {
////                frequencyOfAnimals[animal] = 1
////            }
////        }
////
////        //способ 2:
////        for animal in animals {
////            frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0) + 1
////        }
////
////        //отсортируем по убыванию, чтобы получить "первый" элемент
////        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
////        guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
//
////способ 3:
////Решение в одну строку, без исп. переменных frequencyOfAnimals и animals
////здесь мы использовали анонимные функции, такие как "Dictionary" (имеющую возможность группировать), "sorted" и "first?"
////let mostFrequencyAnimal = Dictionary(grouping: answers, by: {$0.type } )
////        .sorted(by: {$0.value.count > $1.value.count} )
////        .first?.key
//
//    }
//
//    private func updateUI(with animal: AnimalType?) {
//        animalTypeLabel.text = "Вы - \(animal?.rawValue ?? "🐶" )!"
//        descriptionLabel.text = animal?.definition ?? ""
//    }
//}

