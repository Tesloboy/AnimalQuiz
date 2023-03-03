//
//  Question.swift
//  AnimalQuiz
//
//  Created by Viktor Teslenko on 03.03.2023.
//

//создадим энам позволяющий регулировать стеки на экране с вопросами
enum ResponsedType {
    case single
    case multiple
    case range
}

struct Question {
    let text: String
    let type: ResponsedType
    let answers: [Answer]
}

//создадим метод который будет возвращать вопрос и дополним им структуру

extension Question {
    static func getQuestiobns() -> [Question] {
       return [
        Question(text: "Какую еду вы предпочитаете?",
                 type: .single,
                 answers: [
                    Answer(text: "Стейк", type: .dog),
                    Answer(text: "Рыба", type: .cat),
                    Answer(text: "Морковь", type: .rabbit),
                    Answer(text: "Кукуруза", type: .turtle)
                 ]
                ),
        Question(text: "Что вы любите делать?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Плавать", type: .dog),
                    Answer(text: "Спать", type: .cat),
                    Answer(text: "Обниматься", type: .rabbit),
                    Answer(text: "Есть", type: .turtle)
                 ]
                ),
        Question(text: "Любите ли вы поездки на машине?",
                 type: .range,
                 answers: [
                    Answer(text: "Обожаю", type: .dog),
                    Answer(text: "Обожаю", type: .cat),
                    Answer(text: "Ненавижу", type: .rabbit),
                    Answer(text: "Ненавижу", type: .turtle)
                 ]
                )
       ]
    }
}
