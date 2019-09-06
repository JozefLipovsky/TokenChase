//
//  ViewController.swift
//  TokenChase
//
//  Created by Jozef Lipovsky on 2019-08-24.
//  Copyright © 2019 JoLi. All rights reserved.
//

import UIKit

fileprivate let gameGridSize: GridSize = .seven

class ViewController: UIViewController {
    @IBOutlet weak var gridStackView: UIStackView!
    @IBOutlet weak var playerAScoreLabel: UILabel!
    @IBOutlet weak var playerBScoreLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    private let tokenColor: UIColor = .red
    private let playerAColor: UIColor = .green
    private let playerBColor: UIColor = .blue
    private let viewsGrid: Grid<GridItemView> = Grid()
    
    private let game = TokenChaseGame(gameRules: TokenChaseGameRules(grid: TokenChaseGameGrid(gridSize: gameGridSize)),
                                  timer: GameTimer(timerInterval: 0.5),
                                  playerA: Player(currentCoordinate: GridCoordinate(x: gameGridSize.rawValue - 1, y: 0), score: 0),
                                  playerB: Player(currentCoordinate: GridCoordinate(x: 0, y: gameGridSize.rawValue - 1), score: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewsGrid()
        setupUserInterface()
        
        game.delegate = self
        game.reset()
    }
    
    private func setupViewsGrid() {
        for row in 0..<Int(game.gridSize) {
            let columnStackView = UIStackView()
            columnStackView.axis = .vertical
            columnStackView.alignment = .fill
            columnStackView.distribution = .fillEqually
            columnStackView.spacing = gridStackView.spacing

            for _ in 0..<game.gridSize {
                let gridItemView = GridItemView()
                viewsGrid.append(item: gridItemView, toRow: row)
                columnStackView.addArrangedSubview(gridItemView)
            }
            
            gridStackView.addArrangedSubview(columnStackView)
        }
    }
    
    private func setupUserInterface() {
        playerAScoreLabel.textColor = playerAColor
        playerBScoreLabel.textColor = playerBColor
        resetScore(firstPlayerScore: 0, secondPlayerScore: 0)
    }
    
    private func resetScore(firstPlayerScore: Int, secondPlayerScore: Int) {
        playerAScoreLabel.text = String(firstPlayerScore)
        playerBScoreLabel.text = String(secondPlayerScore)
    }

    @IBAction func startButtonTapped(_ sender: UIButton) { 
        if game.isRunning {
            sender.setTitle("Start", for: .normal)
            viewsGrid.resetItemsToDefaultState()
            resetScore(firstPlayerScore: 0, secondPlayerScore: 0)
            game.stop()
            
        } else {
            sender.setTitle("Stop", for: .normal)
            game.start()
        }
    }
}

// MARK:- GameUpdateDelegate

extension ViewController: GameUpdateDelegate {

    func didStartNewRound(tokenUpdate: CoordinateUpdate, playerAInitialCoordinate: GridCoordinate, playerBInitialCoordinate: GridCoordinate) {
        viewsGrid.item(at: tokenUpdate.previousCoordinate)?.resetStateToDefault()
        viewsGrid.item(at: tokenUpdate.nextCoordinate)?.updateState(withColor: tokenColor)
        
        viewsGrid.item(at: playerAInitialCoordinate)?.updateState(withColor: playerAColor)
        viewsGrid.item(at: playerBInitialCoordinate)?.updateState(withColor: playerBColor)
    }
    
    func didMovePlayers(playerAUpdate: CoordinateUpdate, playerBUpdate: CoordinateUpdate) {
        viewsGrid.item(at: playerAUpdate.previousCoordinate)?.updateState(withColor: playerAColor.withAlphaComponent(0.5))
        viewsGrid.item(at: playerAUpdate.nextCoordinate)?.updateState(withColor: playerAColor)
        
        viewsGrid.item(at: playerBUpdate.previousCoordinate)?.updateState(withColor: playerBColor.withAlphaComponent(0.5))
        viewsGrid.item(at: playerBUpdate.nextCoordinate)?.updateState(withColor: playerBColor)
    }
    
    func didFinishRoundWithWin(playerAScore: Int, playerBScore: Int) {
        resetScore(firstPlayerScore: playerAScore, secondPlayerScore: playerBScore)
        viewsGrid.resetItemsToDefaultState()
    }
    
    func didFinishRoundWithStalemate() {
        viewsGrid.resetItemsToDefaultState()
    }
}

