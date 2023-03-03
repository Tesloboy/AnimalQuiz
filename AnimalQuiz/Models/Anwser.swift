//
//  Anwser.swift
//  AnimalQuiz
//
//  Created by Viktor Teslenko on 03.03.2023.
//

//создадим энам позволяющий регулировать стеки на экране с вопросами
enum ResponsedType {
case <#case#>
}

struct Question {
    let text: String
    let type: ResponsedType
    let answers: [Answer]
}
