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
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
         goToFirstState()
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                 self.goToNextState()
            }
            //self.gameboardView.placeMarkView(XView(), at: position)
        }
    }
    // MARK: - actions
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        log(.restartGame)
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
    
    private func goToNextState() {
        
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

 
