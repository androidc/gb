//Created by chizztectep on 10.04.2023 

import Foundation

class PlayerInputState: GameState {
    
   //MARK: - Properties
   private(set) var isCompleted: Bool = false
    let player:Player
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameBoard: Gameboard?
    private(set) weak var gameBoardView: GameboardView?
    
    let markViewPrototype: MarkView
    
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
    
    // MARK: - functions
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else {
            return
        }
        log(.playerInput(player: player, position: position))
        let markView: MarkView
        switch player {
        case .first:
            markView = XView()
        case .second:
            markView = OView()
        }
        
        gameBoard?.setPlayer(player, at: position)
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
        
        isCompleted = true

    }
    
    
}
