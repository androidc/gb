//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Outlets
   
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    //MARK: - Private properties
    
 
    private let gameboard = Gameboard()
    private lazy var  referee = Referee(gameboard: gameboard)
    var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
   
    
    //MARK: - Properties
    var gameType: GameType = .human
   
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Game.shared.gameType = gameType
     

        
         goToFirstState()
        // если ходит компьютер, то позиция выбирается по ИИ (можно реализовать на стратегии). пока реализуем одну стратегию - рандомный выбор незанятой клетки
   
            gameboardView.onSelectPosition = { [weak self] position in
                guard let self = self else { return }
                
                
                self.currentState.addMark(at: position)
                if self.currentState.isCompleted {
                     self.goToNextState()
                }
        }
        
       
            //self.gameboardView.placeMarkView(XView(), at: position)
        
    }
    // MARK: - actions
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        gameboardView.clear()
        gameboard.clear()
        log(.restartGame)
        goToFirstState()
    }
    
    // MARK: - Private Functions
    
    private func goToFirstState() {
        let player = Player.first
        currentState = PlayerInputState(player: player,
                                        markViewPrototype: player.markViewPrototype,
                                        gameViewController: self,
                                        gameBoard: gameboard,
                                        gameBoardView: gameboardView)
    }
    
     func goToNextState() {
        
        if let winner = referee.determineWinner() {
            currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        
        
        if let playerInputState = currentState as? PlayerInputState {
            
            let player = playerInputState.player.next
            currentState = PlayerInputState(player: player,
                                            markViewPrototype: player.markViewPrototype,
                                            gameViewController: self,
                                            gameBoard: gameboard,
                                            gameBoardView: gameboardView)
        }
    }
    
}

 
