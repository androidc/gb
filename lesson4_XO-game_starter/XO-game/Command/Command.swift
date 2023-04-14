//Created by chizztectep on 14.04.2023

// v 1.0 -  State, Prototype, command

import Foundation

protocol Command {
    func execute()
}

// MARK: AddMark Command
class AddMark: Command {
    
    //MARK: - Private properties
    private var position: GameboardPosition
    private(set) weak var gameBoard: Gameboard?
    private let player:Player
    
    // MARK: - Constructors
    init(position: GameboardPosition, gameBoard: Gameboard, player: Player) {
        self.position = position
        self.gameBoard = gameBoard
        self.player = player
    }

    // MARK: - Protocol functions
    func execute() {
        // без всяких проверок мы ставим игрока в выбранную позицию
        gameBoard?.setPlayer(player, at: position)
        
        // сохраняем ход в positions текущего игрока
        switch player {
        case .first:
            Game.shared.firstPositions.append(position)
        case .second:
            Game.shared.secondPositions.append(position)
        case .computer:
            break
        }
    }
}

// MARK: - DrawMark Command
class DrawMark: Command {
    //MARK: - Private properties
    private(set) weak var gameBoardView: GameboardView?
    private(set) weak var gameBoard: Gameboard?
    private let player:Player
    private let position: GameboardPosition?
    
    
    // MARK: - Constructors
    init(gameBoardView: GameboardView, player: Player, position: GameboardPosition, gameBoard: Gameboard) {
        self.gameBoardView = gameBoardView
        self.player = player
        self.position = position
        self.gameBoard = gameBoard
    }
    
    // MARK: - Protocol functions
    func execute() {
        
        guard let gameBoardView = gameBoardView else {
            return
        }
        guard let position = position else {
            return
        }
        gameBoardView.placeMarkViewWithoutCheck(player.markViewPrototype.copy(), at: position)
        gameBoard!.setPlayer(player, at: position)
    }
}
