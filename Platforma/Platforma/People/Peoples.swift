//Created by chizztectep on 06.05.2023 

import Foundation

struct Names {
    let names:[String] = [
        "Блохина Юлия Фомевна",
        "Челомцев Ярослав Сергеевич",
        "Панкин Анатолий Данилевич",
        "Дыховичный Алла Вячеславовна",
        "Колиух Лев Федотович",
        "Цветкова Елизавета Ираклиевна",
        "Коровин Константин Проклович",
        "Остапюка Вероника Данииловна",
        "Кулактина Светлана Игоревна",
        "Щукин Леонид Глебович",
        "Подмазко Любовь Николаевна",
        "Другаль Ангелина Андрияновна",
        "Ошуркова Нина Германовна",
        "Каштанова Галина Петровна",
        "Трухина Ангелина Тихоновна",
        "Степанова Анфиса Николаевна",
        "Титов Евгений Даниилович",
        "Решетников Алексей Еремеевич",
        "Яйцов Олег Савелиевич",
        "Шуличенко Алиса Ивановна",
        "Драгомирова Любава Ираклиевна",
        "Механтьев Артур Олегович",
        "Савинкова Вероника Федотовна",
        "Кошелькова Ангелина Потаповна",
        "Пустов Лев Викентиевич",
        "Букин Тимофей Георгиевич",
        "Черенчикова Тамара Игнатиевна",
        "Хемлин Лев Прохорович",
        "Ёжиков Иван Елисеевич",
        "Надервель Андрей Федотович",
        "Парфёнова Ульяна Ираклиевна",
        "Яхимовича Дарья Георгиевна",
        "Селезнева Виктория Ираклиевна",
        "Лапухина Ульяна Брониславовна",
        "Эльмпта Светлана Ильевна",
        "Яушкин Вадим Потапович"
       
    ]
}

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
        victims.append(Victim(name: "Титов Евгений Даниилович"))
        return victims
    }
    
    /// возвращает 20 жителей платформы
    static func generateTwentyVictims() -> [Victim] {
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
        victims.append(Victim(name: "Черенчикова Тамара Игнатиевна"))
        victims.append(Victim(name: "Хемлин Лев Прохорович"))
        victims.append(Victim(name: "Чак Норрис"))
        victims.append(Victim(name: "Лапухина Ульяна Брониславовна"))
        victims.append(Victim(name: "Эльмпта Светлана Ильевна"))
        victims.append(Victim(name: "Ошуркова Нина Германовна"))
        victims.append(Victim(name: "Подмазко Любовь Николаевна"))
        victims.append(Victim(name: "Панкин Анатолий Данилевич"))
        victims.append(Victim(name: "Яушкин Вадим Потапович"))
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
