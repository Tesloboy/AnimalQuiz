//
//  Answer.swift
//  AnimalQuiz
//
//  Created by Viktor Teslenko on 03.03.2023.
//


struct Answer {
    let text: String
    let type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которым всегда готовы помочь!"
        case .cat:
            return "Вы Кот"
        case .rabbit:
            return "Вы Кролик"
        case .turtle:
            return "Вы Черепаха"
        }
    }
}
