//Created by chizztectep on 12.04.2023

// v 1.0 -  State, Prototype, command

import Foundation

class GameEndedFiveState: GameState {
    
    let isCompleted: Bool = false

    let first: Player
    let second: Player
    
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameBoard: Gameboard?
    private(set) weak var gameBoardView: GameboardView?
    private(set) var  referee:Referee?
    
    // MARK: - Construction
    init( gameViewController: GameViewController, gameBoard: Gameboard, first: Player, second: Player, gameBoardView: GameboardView) {
      
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.first = first
        self.second = second
        self.gameBoardView = gameBoardView
        self.referee = Referee(gameboard: gameBoard)
    }
    
    // MARK: - protocol functions
    func begin() {
        
        guard let gameBoardView = gameBoardView else {
            return
        }
        // делаем ходы игроков
        PlayerActionInvoker.shared.executeCommands()
        // показать по очереди ходы игроков
        for i in 0...4 {
         
            // добавляем команды в PlayerActionInvoker
            PlayerActionInvoker.shared.addCommand(DrawMark(gameBoardView: gameBoardView, player: first, position: Game.shared.firstPositions[i], gameBoard: gameBoard!))
            PlayerActionInvoker.shared.addCommand(DrawMark(gameBoardView: gameBoardView, player: second, position: Game.shared.secondPositions[i], gameBoard: gameBoard!))
            
//            //  показать ход первого игрока
//            gameBoardView.placeMarkViewWithoutCheck(first.markViewPrototype.copy(), at: Game.shared.firstPositions[i])
//            gameBoard!.setPlayer(first, at: Game.shared.firstPositions[i])
//
//            gameBoardView.placeMarkViewWithoutCheck(second.markViewPrototype.copy(), at: Game.shared.secondPositions[i])
//            gameBoard!.setPlayer(second, at: Game.shared.secondPositions[i])
          
        }
        // отображаем ходы на доске
        PlayerActionInvoker.shared.executeCommands()
        // выполняем все команды из PlayerActionInvoker
        
       
        
        // вывести имя победителя
        let winner = referee!.determineWinner()
        gameViewController?.winnerLabel.isHidden = false
        if let winner = winner {
            gameViewController?.winnerLabel.text = winnerName(from: winner) + " win"
        } else {
            gameViewController?.winnerLabel.text = "no winner"
        }
        
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
        
       
    }
    
    func addMark(at position: GameboardPosition) {}
    
    // MARK: - private functions
    private func winnerName(from winner: Player) -> String {
        switch winner {
        case .first:
            return "1st player"
        case .second:
            return "2st player"
        case .computer:
            return "computer"
        }
    }
    
}
