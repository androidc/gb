//Created by chizztectep on 10.04.2023 

import Foundation

class GameEndedState: GameState {
    let isCompleted: Bool = false
    let winner: Player?
    
    private(set) weak var gameViewController: GameViewController?
    
    // MARK: - Construction
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    // MARK: - protocol functions
    func begin() {
        gameViewController?.winnerLabel.isHidden = false
        
        if let winner = winner {
            gameViewController?.winnerLabel.text = winnerName(from: winner) + " win"
        } else {
            gameViewController?.winnerLabel.text = "no winner"
        }
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
        log(.gameFinish(winner: winner))
    }
    func addMark(at position: GameboardPosition) {}
    
    // MARK: - private functions
    private func winnerName(from winner: Player) -> String {
        switch winner {
        case .first:
            return "1st player"
        case .second:
            return "2st player"
        }
    }
}
