#  <#Title#>

Выбор первого игрока  goToFirstState() 
переключение на state первого игрока
там begin - switch labels
потом addMark 1 -го
запись позиции для referree  gameBoard?.setPlayer(player, at: position)
Простановка марки gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
и completed = true
Потом переход на 2-го игрока
Перед переходом определение победителя
если есть winner или он не определен но игра закончена переход на GameEndedState
если нет победителя и игра не закончена, то переход на state следующего игрока и все по новой

в определении следующего можно вставить компуктер и везде добавить обработку .computer 


