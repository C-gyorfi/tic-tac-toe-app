//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Csabi on 04/05/2018.
//  Copyright © 2018 Csabi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isActiveGame = true
    
    var moves = 0
    
    var activePlayer = 1 //1 is O 2 is X
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0] // 0 -empty, 1 - Noughts, 2 - Crosses
    
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8], [2,4,6]]

    @IBOutlet weak var winningLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let activePosition = sender.tag - 1
        
        if gameState[activePosition] == 0 {
            
            gameState[activePosition] = activePlayer
            moves += 1
        
            if activePlayer == 1 {
                
                sender.setImage(UIImage(named: "O.png"), for: [])
                activePlayer = 2

            } else {
        
                sender.setImage(UIImage(named: "X.png"), for: [])
                activePlayer = 1
            }
            
            checkForWinner()
        }
    }
    
    private func checkForWinner() {
        for combination in winningCombinations {
            
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                
                isActiveGame = false
                
                winningLabel.isHidden = false
                playAgainButton.isHidden = false
                
                if gameState[combination[0]] == 1 {
                    winningLabel.text = "Noughts has won!"
                } else {
                    
                    winningLabel.text = "Crosses has won!"
                }
                
                UIView.animate(withDuration: 1, animations: {
                    self.winningLabel.center = CGPoint(x: self.winningLabel.center.x + 500, y: self.winningLabel.center.y)
                    self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x, y: self.playAgainButton.center.y + 1000)
                })
                
            }
                
            else if isBoardFull() && isActiveGame {
                winningLabel.text = "it's a tie..."
                winningLabel.isHidden = false
                playAgainButton.isHidden = false
                
                UIView.animate(withDuration: 1, animations: {
                    self.winningLabel.center = CGPoint(x: self.winningLabel.center.x + 500, y: self.winningLabel.center.y)
                    self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x, y: self.playAgainButton.center.y + 1000)
                })
            }
        }
    }
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        
        isActiveGame = true
        moves = 0
        activePlayer = 1
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0] // 0 -empty, 1 - Noughts, 2 - Crosses
        
        for n in 1..<10 {
        
            if let button = view.viewWithTag(n) as? UIButton {
                button.setImage(nil, for: [])
            }
            
            self.playAgainButton.isHidden = true
            self.winningLabel.isHidden = true
            
            winningLabel.center = CGPoint(x: winningLabel.center.x - 500, y:winningLabel.center.y)
            playAgainButton.center = CGPoint(x: playAgainButton.center.x, y:playAgainButton.center.y-500)
        }
    }
    
    private func isBoardFull() -> Bool {
        return moves == 9
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playAgainButton.isHidden = true
        self.winningLabel.isHidden = true
        
        winningLabel.center = CGPoint(x: winningLabel.center.x - 500, y:winningLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x, y:playAgainButton.center.y-500)
    }
}

