//Created by chizztectep on 12.04.2023

// v 1.0 -  State, Prototype, command

import Foundation

class Player5InputState: GameState {
  
    
    //MARK: - Properties
    private(set) var isCompleted: Bool = false
     let player:Player
     private(set) weak var gameViewController: GameViewController?
     private(set) weak var gameBoard: Gameboard?
     private(set) weak var gameBoardView: GameboardView?
    

    
    let markViewPrototype: MarkView
    var markCount: Int = 0
    
    // MARK: - Constructions
    init(player: Player,
         markViewPrototype: MarkView,
         gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView) {
        self.markViewPrototype = markViewPrototype
        self.player = player
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.gameViewController = gameViewController
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        case .computer: break
        }
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        
        // это будет выполняться в команде AddMark
        // без всяких проверок мы ставим игрока в выбранную позицию
        //gameBoard?.setPlayer(player, at: position)
           
//        // сохраняем ход в positions текущего игрока
       
//        switch player {
//        case .first:
//            Game.shared.firstPositions.append(position)
//        case .second:
//            Game.shared.secondPositions.append(position)
//        case .computer:
//            break
//        }
        guard let gameBoard = gameBoard else {
            return
        }
        
        PlayerActionInvoker.shared.addCommand(AddMark(position: position, gameBoard: gameBoard, player: player))
        markCount += 1
        // когда игрок поставит 5 отметок, то возвращаем isCompleted = true
        if markCount == 5 {
            isCompleted = true
        }
    }
    
    
    
}
