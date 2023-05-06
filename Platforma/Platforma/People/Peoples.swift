//Created by chizztectep on 06.05.2023 

import Foundation

class People {
    
    
    /// возвращает 10 жителей платформы
    static func generateTenVictims() -> [Victim] {
        var victims:[Victim] = []
        victims.append(Victim(name: "Лобачёва Любовь Марковна"))
        victims.append(Victim(name: "Онипченко Вячеслав Сигизмундович"))
        victims.append(Victim(name: "Ширяева Тамара Леонидовна"))
        victims.append(Victim(name: "Дресвянин Аркадий Егорович"))
        victims.append(Victim(name: "Эйлера Милена Филипповна"))
        victims.append(Victim(name: "Кутяков Сергей Кириллович"))
        victims.append(Victim(name: "Цой Всеволод Евлампиевич"))
        victims.append(Victim(name: "Рудин Святослав Ираклиевич"))
        victims.append(Victim(name: "Стегнов Петр Всеволодович"))
        victims.append(Victim(name: "Яковалева Лилия Евгениевна"))
        return victims
    }

    /// заготовка для динамичесого формирования жителей платформы
    static func generateVictims(count: Int) -> [Victim] {
        var victims:[Victim] = []
        
        for i in 1...count {
        }
        
        return victims
    }
}
