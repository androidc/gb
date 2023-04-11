//Created by chizztectep on 11.04.2023 

import Foundation

protocol ComputerStrategy {
    func selectPosition() -> GameboardPosition?
}

/**
      Стратегия выбирает случайную ячейку на доске. если ячейка занята, то выбирает следующую по стратегии NextPositionComputerStrategy
 */
class RandomComputerStrategy: ComputerStrategy {
    let columnsCount = GameboardSize.columns
    let rowsCount = GameboardSize.rows
    private(set) var gameBoardView: GameboardView
    
    init(gameBoardView: GameboardView) {
        self.gameBoardView = gameBoardView
    }
    
    func selectPosition() -> GameboardPosition? {
        // get random column and row
        let randColumn = Int(arc4random_uniform(UInt32(columnsCount)))
        let randomRow = Int(arc4random_uniform(UInt32(rowsCount)))
        let gameBoardPosition = GameboardPosition(column: randColumn, row: randomRow)
        if gameBoardView.canPlaceMarkView(at: gameBoardPosition) {return gameBoardPosition} else
        {
            let nextPositionStrategy: NextPositonComputerStrategy = NextPositonComputerStrategy(gameBoardView: self.gameBoardView)
            return nextPositionStrategy.selectPosition()
        }
        
    }
}

/**
      Стратегия выбирает следующую незанятую ячейку, либо возвращает nil
 */
class NextPositonComputerStrategy: ComputerStrategy {
    var columnIndex:Int = 0
    var rowIndex:Int = 0
    
    private(set) var gameBoardView: GameboardView
   
    init(gameBoardView: GameboardView) {
        self.gameBoardView = gameBoardView
    }
 
    
    func selectPosition() -> GameboardPosition? {
        var gameBoardPosition = GameboardPosition(column: 0, row: 0)
        repeat {
            if gameBoardView.canPlaceMarkView(at: gameBoardPosition) {
                return gameBoardPosition} else
            {
                let (row,col) = nextPosition(row: rowIndex, column: columnIndex)
                gameBoardPosition = GameboardPosition(column: col, row: row)
                columnIndex = col
                rowIndex = row
            }
        } while  (columnIndex<3 && rowIndex<3)
        // если дошли до конца и не нашли свободной ячейки то
        return nil
    }
    
    // private func
    
    func nextPosition(row: Int, column: Int) -> (Int,Int) {
        let currentPosition: (Int, Int) = (row,column)
        let (row, col) = currentPosition
        
        // col = 2, row = 0 => 1, 0
        // col = 2 , row = 1 => 2, 0
        // col = 1 , row = 0 => 0 , 2
        // col = 1, row = 2 => 2,2
        if col == GameboardSize.columns - 1 {
            return (row + 1, 0)
        } else {
            return (row, col + 1)
        }
        
        
//        if col == GameboardSize.columns - 1 { // If we're at the end of the row
//                return (0, row + 1) // Move to the next row, first column
//            } else { // Otherwise
//                return (col + 1,row) // Move to the next column in the same row
//            }


    }
    
 
        
   
}
