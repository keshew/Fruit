import SwiftUI
import SpriteKit

enum CellOwner {
    case none, player, enemy
}

struct CellState {
    var owner: CellOwner
    var size: Int
}

enum Turn {
    case player
    case enemy
}

class GameData: ObservableObject {
    @Published var isPause = false
    @Published var isMenu = false
    @Published var isWin = false
    @Published var isLose = false
    @Published var isRules = false
    @Published var scene = SKScene()
}

extension GameSpriteKit {
    func createTappedNode() {
        let pause = SKSpriteNode(imageNamed: "pause")
        pause.name = "pause"
        pause.size = CGSize(width: 70, height: 90)
        pause.position = CGPoint(x: size.width / 8, y: size.height / 1.13)
        addChild(pause)
        
        let rules = SKSpriteNode(imageNamed: "rules")
        rules.name = "rules"
        rules.size = CGSize(width: 70, height: 90)
        rules.position = UIScreen.main.bounds.width > 900 ? CGPoint(x: size.width / 8, y: size.height / 1.25) : (UIScreen.main.bounds.width > 600 ? CGPoint(x: size.width / 8, y: size.height / 1.25) : CGPoint(x: size.width / 8, y: size.height / 1.28))
        addChild(rules)
        
        let bonusMoves = SKSpriteNode(imageNamed: "bonusMove")
        bonusMoves.name = "bonusMoves"
        bonusMoves.size = CGSize(width: 75, height: 100)
        bonusMoves.position = CGPoint(x: size.width / 8, y: size.height / 10)
        addChild(bonusMoves)
        
        let bonusMultiply = SKSpriteNode(imageNamed: "bonusMultiply")
        bonusMultiply.name = "bonusMultiply"
        bonusMultiply.size = CGSize(width: 85, height: 100)
        bonusMultiply.position = CGPoint(x: size.width / 1.18, y: size.height / 10)
        addChild(bonusMultiply)
        
        bonusMovesLabel = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
        bonusMovesLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.object(forKey: Keys.moveBonus.rawValue) as? Int ?? 1)" , attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 16)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        bonusMovesLabel.position = CGPoint(x: bonusMoves.size.width * 0.31, y: -bonusMoves.size.height * 0.11)
        bonusMoves.addChild(bonusMovesLabel)
        
        bonusMultiplyLabel = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
        bonusMultiplyLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.object(forKey: Keys.pointsBonus.rawValue) as? Int ?? 1)" , attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 16)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        bonusMultiplyLabel.position = CGPoint(x: -bonusMultiply.size.width * 0.325, y: -bonusMultiply.size.height * 0.115)
        bonusMultiply.addChild(bonusMultiplyLabel)
    }
    
    func createMainNode() {
        let gameBackground = SKSpriteNode(imageNamed: "bg")
        gameBackground.size = CGSize(width: size.width, height: size.height)
        gameBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameBackground)
        
        let backMoney = SKSpriteNode(imageNamed: "backCoin")
        backMoney.size = CGSize(width: 184, height: 50)
        backMoney.position = CGPoint(x: size.width / 1.3, y: size.height / 1.13)
        addChild(backMoney)
        
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.size = CGSize(width: 64, height: 64)
        coin.position = CGPoint(x: -backMoney.size.width * 0.45, y: 0)
        backMoney.addChild(coin)
        
        let coinLabel = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
        coinLabel.attributedText = NSAttributedString(string: "COINS:" , attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 19)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        coinLabel.position = CGPoint(x: backMoney.size.width * 0.02, y: -backMoney.size.height * 0.05)
        backMoney.addChild(coinLabel)
        
        let coinCountLabel = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
        coinCountLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1)" , attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 19)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        coinCountLabel.position = CGPoint(x: backMoney.size.width * 0.02, y: -backMoney.size.height * 0.35)
        backMoney.addChild(coinCountLabel)

        let backlifes = SKSpriteNode(imageNamed: "backCoin")
        backlifes.size = CGSize(width: 184, height: 50)
        backlifes.position = UIScreen.main.bounds.width > 900 ? CGPoint(x: size.width / 1.3, y: size.height / 1.22) : (UIScreen.main.bounds.width > 600 ? CGPoint(x: size.width / 1.3, y: size.height / 1.23) : CGPoint(x: size.width / 1.3, y: size.height / 1.25))
        addChild(backlifes)
        
        let life = SKSpriteNode(imageNamed: "life")
        life.size = CGSize(width: 74, height: 64)
        life.position = CGPoint(x: -backlifes.size.width * 0.45, y: 0)
        backlifes.addChild(life)
        
        let lifeLabel = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
        lifeLabel.attributedText = NSAttributedString(string: "LIFES:", attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 18)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        lifeLabel.position = CGPoint(x: backlifes.size.width * 0.04, y: -backlifes.size.height * 0.05)
        backlifes.addChild(lifeLabel)
        
        let lifeCountLabel = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
        lifeCountLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.object(forKey: Keys.life.rawValue) as? Int ?? 1)", attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 18)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        lifeCountLabel.position = CGPoint(x: backlifes.size.width * 0.04, y: -backlifes.size.height * 0.35)
        backlifes.addChild(lifeCountLabel)

        let gameLevelLabel = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
        gameLevelLabel.attributedText = NSAttributedString(string: "LEVEL \(level)", attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 45)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        gameLevelLabel.position = CGPoint(x: size.width / 2, y: size.height / 1.43)
        addChild(gameLevelLabel)
    }
    
    func createMoveNode() {
        let yourMoves = SKSpriteNode(imageNamed: "yourMoves")
        yourMoves.size = CGSize(width: 90, height: 40)
        yourMoves.position = CGPoint(x: size.width / 2.8, y: size.height / 9)
        addChild(yourMoves)
        
        let youMovesLabel = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
        youMovesLabel.attributedText = NSAttributedString(string: "YOUR POINT", attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 15)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        youMovesLabel.position = CGPoint(x: 0, y: 30)
        yourMoves.addChild(youMovesLabel)
        
        yourMovesCountLabel = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
        yourMovesCountLabel.attributedText = NSAttributedString(string: "6" , attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 20)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        yourMovesCountLabel.position = CGPoint(x: 0, y: -10)
        yourMoves.addChild(yourMovesCountLabel)
        
        let enemyMoves = SKSpriteNode(imageNamed: "enemyMoves")
        enemyMoves.size = CGSize(width: 90, height: 40)
        enemyMoves.position = CGPoint(x: size.width / 1.65, y: size.height / 9)
        addChild(enemyMoves)
        
        let enemyLabel = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
        enemyLabel.attributedText = NSAttributedString(string: "ENEMY POINT", attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 15)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        enemyLabel.position = CGPoint(x: 0, y: 30)
        enemyMoves.addChild(enemyLabel)
        
        enemyMovesCountLabel = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
        enemyMovesCountLabel.attributedText = NSAttributedString(string: "6" , attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 20)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        enemyMovesCountLabel.position = CGPoint(x: 0, y: -10)
        enemyMoves.addChild(enemyMovesCountLabel)
    }
    
    func returnFruitImage() -> String {
        return ["fruit1", "fruit2", "fruit3", "fruit4", "fruit5", "fruit6", "fruit7", "fruit8"].randomElement() ?? "fruit1"
    }
    
    func returnNumber() -> String {
        return ["1", "2", "3", "4", "5", "6", "7"].randomElement() ?? "fruit1"
    }
}

class GameSpriteKit: SKScene, SKPhysicsContactDelegate {
    var game: GameData?
    var level: Int
    var cellStates = Array(
        repeating: Array(repeating: CellState(owner: .none, size: 0), count: 6),
        count: 6
    )
    var isDoublePointsActive = false
    var playerHasExtraTurn = false
    var currentTurn: Turn = .player
    var isEnemyThinking = false
    var yourMovesCountLabel: SKLabelNode!
    var enemyMovesCountLabel: SKLabelNode!
    var bonusMovesLabel: SKLabelNode!
    var bonusMultiplyLabel: SKLabelNode!
    
    init(level: Int) {
        self.level = level
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        size = UIScreen.main.bounds.size
        createMainNode()
        createTappedNode()
        createDescNode()
        createMoveNode()
        updateScores()
    }
    
    func createDescNode() {
        let desc = SKSpriteNode(imageNamed: "desc")
        desc.size = UIScreen.main.bounds.width > 900 ? CGSize(width: 720, height: 720) : (UIScreen.main.bounds.width > 600 ? CGSize(width: 610, height: 610) : CGSize(width: 400, height: 420))
        desc.position = CGPoint(x: size.width / 2, y: size.height / 2.4)
        addChild(desc)

        let squareSize: CGFloat = UIScreen.main.bounds.width > 900 ? 93 : (UIScreen.main.bounds.width > 600 ? 80 : 48)
        let spacing: CGFloat = 15
        let columns = 6
        let rows = 6

        let totalWidth = CGFloat(columns) * squareSize + CGFloat(columns - 1) * spacing
        let totalHeight = CGFloat(rows) * squareSize + CGFloat(rows - 1) * spacing

        let startX = desc.position.x - totalWidth / 2 + squareSize / 2
        let startY = desc.position.y - totalHeight / 2 + squareSize / 2

        let myNodes = [
            (5,0),
            (4,0), (5,1),
            (3,0), (4,1), (5,2)
        ]
        let enemyNodes = [
            (0,5),
            (1,5), (1,4),
            (2,5), (0,4), (0,3)
        ]

        for row in 0..<rows {
            for column in 0..<columns {
                var fillColor = UIColor.clear
                var numberText: String?
                var imageFruit: String?

                if myNodes.contains(where: { $0 == (row, column) }) {
                    fillColor = UIColor(red: 183/255, green: 1/255, blue: 144/255, alpha: 1)
                    let number = returnNumber()
                    numberText = number
                    imageFruit = returnFruitImage()
                    cellStates[row][column] = CellState(owner: .player, size: Int(number) ?? 1)
                } else if enemyNodes.contains(where: { $0 == (row, column) }) {
                    fillColor = UIColor(red: 43/255, green: 4/255, blue: 184/255, alpha: 1)
                    let number = returnNumber()
                    numberText = number
                    imageFruit = returnFruitImage()
                    cellStates[row][column] = CellState(owner: .enemy, size: Int(number) ?? 1)
                } else {
                    cellStates[row][column] = CellState(owner: .none, size: 0)
                }

                let square = SKShapeNode(rectOf: CGSize(width: squareSize, height: squareSize), cornerRadius: 15)
                square.fillColor = fillColor
                square.strokeColor = .white
                square.lineWidth = 1.5
                square.name = "cell_\(row)_\(column)"
          
                if let text = numberText {
                    let label = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
                    label.name = "digitLabel"
                    label.userData = ["isPredefined": true]
                    label.attributedText = NSAttributedString(string: text, attributes: [
                        .font: UIFont(name: "LuckiestGuy-Regular", size: UIScreen.main.bounds.width > 900 ? 26 : (UIScreen.main.bounds.width > 600 ? 24 : 16))!,
                        .foregroundColor: UIColor.white,
                        .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
                        .strokeWidth: -2.5
                    ])
                  
                    label.verticalAlignmentMode = .center
                    label.horizontalAlignmentMode = .center
                    label.position = UIScreen.main.bounds.width > 900 ? CGPoint(x: -25, y: -25) : (UIScreen.main.bounds.width > 600 ? CGPoint(x: -20, y: -21) : CGPoint(x: -13, y: -11))
                    square.addChild(label)
                }

                if let _ = imageFruit {
                    let image = SKSpriteNode(imageNamed: returnFruitImage())
                    image.size = UIScreen.main.bounds.width > 900 ? CGSize(width: 50, height: 50) : (UIScreen.main.bounds.width > 600 ? CGSize(width: 40, height: 40) : CGSize(width: 25, height: 25))
                    image.name = "fruitImage"
                    image.position = UIScreen.main.bounds.width > 900 ? CGPoint(x: 13, y: 15) : (UIScreen.main.bounds.width > 600 ? CGPoint(x: 10, y: 10) : CGPoint(x: 5, y: 5))
                    square.addChild(image)
                }

                let posX = startX + CGFloat(column) * (squareSize + spacing)
                let posY = startY + CGFloat(row) * (squareSize + spacing)
                square.position = CGPoint(x: posX, y: posY)

                addChild(square)
            }
        }
    }
    
    func handleCellTap(row: Int, column: Int) {
        guard currentTurn == .player && !isEnemyThinking else { return }

        var cell = cellStates[row][column]

        switch cell.owner {
        case .none:
            cell.owner = .player
            cell.size = 1
        case .player:
            if isDoublePointsActive {
                cell.size *= 2
                isDoublePointsActive = false
            } else {
                cell.size += 1
            }
        case .enemy:
            cell.owner = .player
            cell.size += 1
        }

        cellStates[row][column] = cell
        updateCellNode(row: row, column: column)

        let unstableLimit = getUnstableLimit(row: row, column: column)

        if cell.size >= unstableLimit {
            cell.size = 1
            cellStates[row][column] = cell
            updateCellNode(row: row, column: column)
            triggerExplosion(row: row, column: column, owner: .player)
        }

        if playerHasExtraTurn {
            playerHasExtraTurn = false
        } else {
            currentTurn = .enemy
            run(SKAction.wait(forDuration: 1.0)) { [weak self] in
                self?.enemyMakeMove()
            }
        }
        updateScores()
    }

    func enemyMakeMove() {
        guard currentTurn == .enemy else { return }
        isEnemyThinking = true

        var possibleMoves: [(row: Int, column: Int)] = []

        for row in 0..<6 {
            for col in 0..<6 {
                let cell = cellStates[row][col]
                if cell.owner == .none || cell.owner == .enemy || cell.owner == .player {
                    possibleMoves.append((row, col))
                }
            }
        }

        guard let move = possibleMoves.randomElement() else {
            isEnemyThinking = false
            currentTurn = .player
            return
        }

        run(SKAction.wait(forDuration: 0.5)) { [weak self] in
            self?.handleEnemyTap(row: move.row, column: move.column)
        }
    }

    func updateScores() {
        var playerScore = 0
        var enemyScore = 0

        for row in 0..<6 {
            for col in 0..<6 {
                let cell = cellStates[row][col]
                switch cell.owner {
                case .player:
                    playerScore += cell.size
                case .enemy:
                    enemyScore += cell.size
                case .none:
                    break
                }
            }
        }

        yourMovesCountLabel.attributedText = NSAttributedString(string: "\(playerScore)" , attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 20)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])

        enemyMovesCountLabel.attributedText = NSAttributedString(string: "\(enemyScore)" , attributes: [
            .font: UIFont(name: "LuckiestGuy-Regular", size: 20)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
            .strokeWidth: -2.5
        ])
        
        
        if playerScore >= 50 {
            game?.isWin = true
        } else if enemyScore >= 50 {
            game?.isLose = true
        }
    }
    
    func handleEnemyTap(row: Int, column: Int) {
        var cell = cellStates[row][column]

        switch cell.owner {
        case .none:
            cell.owner = .enemy
            cell.size = 1
        case .enemy:
            cell.size += 1
        case .player:
            cell.owner = .enemy
            cell.size += 1
        }

        cellStates[row][column] = cell
        updateCellNode(row: row, column: column)

        let unstableLimit = getUnstableLimit(row: row, column: column)

        if cell.size >= unstableLimit {
            cell.size = 1
            cellStates[row][column] = cell
            updateCellNode(row: row, column: column)
            triggerExplosion(row: row, column: column, owner: .enemy)
        }

        isEnemyThinking = false
        currentTurn = .player
        updateScores()
    }

    func getUnstableLimit(row: Int, column: Int) -> Int {
        if (row == 0 && column == 0) || (row == 0 && column == 5) ||
           (row == 5 && column == 0) || (row == 5 && column == 5) {
            return 4
        } else if row == 0 || row == 5 || column == 0 || column == 5 {
            return 6
        } else {
            return 9
        }
    }

    func triggerExplosion(row: Int, column: Int, owner: CellOwner) {
        let directions = [(-1,-1), (-1,0), (-1,1), (0,-1), (0,1), (1,-1), (1,0), (1,1)]
        
        for (dr, dc) in directions {
            let nr = row + dr
            let nc = column + dc
            if nr >= 0 && nr < 6 && nc >= 0 && nc < 6 {
                var neighbor = cellStates[nr][nc]
                neighbor.owner = owner
                neighbor.size += 1
                
                let unstableLimit = getUnstableLimit(row: nr, column: nc)
                if neighbor.size >= unstableLimit {
                    neighbor.size = 1
                    cellStates[nr][nc] = neighbor
                    updateCellNode(row: nr, column: nc)
                    triggerExplosion(row: nr, column: nc, owner: owner)
                } else {
                    cellStates[nr][nc] = neighbor
                    updateCellNode(row: nr, column: nc)
                }
            }
        }
    }

    func updateCellNode(row: Int, column: Int) {
        let name = "cell_\(row)_\(column)"
        guard let square = childNode(withName: name) as? SKShapeNode else { return }
        let cell = cellStates[row][column]

        if let oldEffectNode = square.childNode(withName: "highlightEffect") {
            oldEffectNode.removeFromParent()
            print("deleted highlightEffect")
        }

        let cellColor: UIColor
        let highlightColor: UIColor
        switch cell.owner {
        case .player:
            cellColor = UIColor(red: 183/255, green: 1/255, blue: 144/255, alpha: 1)
            highlightColor = UIColor(red: 183/255, green: 1/255, blue: 144/255, alpha: 0.3)
        case .enemy:
            cellColor = UIColor(red: 43/255, green: 4/255, blue: 184/255, alpha: 1)
            highlightColor = UIColor(red: 43/255, green: 4/255, blue: 184/255, alpha: 0.3)
        case .none:
            cellColor = .clear
            highlightColor = .clear
        }
        square.fillColor = cellColor

        if let oldLabel = square.childNode(withName: "digitLabel") {
            oldLabel.removeFromParent()
        }
        if cell.size > 0 {
            let label = SKLabelNode(fontNamed: "LuckiestGuy-Regular")
            label.name = "digitLabel"
            label.text = "\(cell.size)"
            label.fontSize = 16
            label.fontColor = .white
            label.position = CGPoint(x: -13, y: -11)
            label.verticalAlignmentMode = .center
            label.horizontalAlignmentMode = .center
            square.addChild(label)
        }

        if let oldImage = square.childNode(withName: "fruitImage") {
            oldImage.removeFromParent()
        }
        if cell.owner != .none {
            let image = SKSpriteNode(imageNamed: returnFruitImage())
            image.name = "fruitImage"
            image.size = CGSize(width: 25, height: 25)
            image.position = CGPoint(x: 5, y: 5)
            square.addChild(image)
        }

        let unstableLimit = getUnstableLimit(row: row, column: column)
        if cell.size >= unstableLimit - 1 && cell.owner != .none {
            let highlight = SKShapeNode(rectOf: CGSize(width: square.frame.width + 5, height: square.frame.height + 5), cornerRadius: 20)
            highlight.name = "highlight"
            highlight.fillColor = highlightColor
            highlight.strokeColor = .red
            highlight.alpha = 0.7

            let effectNode = SKEffectNode()
            effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 4])
            effectNode.name = "highlightEffect"
            effectNode.shouldRasterize = true
            effectNode.addChild(highlight)
            square.addChild(effectNode)
            
            print("row: \(row), column: \(column), size: \(cell.size), owner: \(cell.owner), unstableLimit: \(unstableLimit)")
            if cell.size >= unstableLimit - 1 && cell.owner != .none {
                print("Добавляю подсветку для клетки (\(row), \(column))")
            }
        }
    }
    
    func pauseTapped(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "pause" {
            game!.isPause = true
            game!.scene = scene!
            scene?.isPaused = true
        }
    }
    
    func bonusPointTapped(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "bonusMultiply" {
            if UserDefaultsManager.defaults.object(forKey: Keys.pointsBonus.rawValue) as? Int ?? 1 >= 1 {
                UserDefaultsManager().usePointsBonus()
                isDoublePointsActive = true
                bonusMultiplyLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.object(forKey: Keys.pointsBonus.rawValue) as? Int ?? 1)" , attributes: [
                    .font: UIFont(name: "LuckiestGuy-Regular", size: 16)!,
                    .foregroundColor: UIColor.white,
                    .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
                    .strokeWidth: -2.5
                ])
            }
        }
    }
    
    func bonusMoveTapped(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "bonusMoves" {
            if UserDefaultsManager.defaults.object(forKey: Keys.moveBonus.rawValue) as? Int ?? 1 >= 1 {
                UserDefaultsManager().useMoveBonus()
                playerHasExtraTurn = true
                bonusMovesLabel.attributedText = NSAttributedString(string: "\(UserDefaultsManager.defaults.object(forKey: Keys.moveBonus.rawValue) as? Int ?? 1)" , attributes: [
                    .font: UIFont(name: "LuckiestGuy-Regular", size: 16)!,
                    .foregroundColor: UIColor.white,
                    .strokeColor: UIColor(red: 158/255, green: 40/255, blue: 250/255, alpha: 1),
                    .strokeWidth: -2.5
                ])
            }
        }
    }
    
    func rulesTapped(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "rules" {
            game!.isRules = true
            game!.scene = scene!
            scene?.isPaused = true
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        pauseTapped(touchLocation: location)
        rulesTapped(touchLocation: location)
        bonusMoveTapped(touchLocation: location)
        bonusPointTapped(touchLocation: location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodes = nodes(at: location)
        for node in nodes {
            if let name = node.name, name.starts(with: "cell_") {
                let parts = name.split(separator: "_")
                if parts.count == 3,
                   let row = Int(parts[1]),
                   let column = Int(parts[2]) {
                    handleCellTap(row: row, column: column)
                }
            }
        }
    }
}

struct FruitGameView: View {
    @StateObject var fruitGameModel =  FruitGameViewModel()
    @StateObject var gameModel = GameData()
    var level: Int
    
    var body: some View {
        ZStack {
            SpriteView(scene: fruitGameModel.createGameScene(gameData: gameModel, level: level))
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            if gameModel.isWin {
                FruitWinView(game: gameModel, scene: gameModel.scene, level: level + 1)
                    .onAppear {
                        UserDefaultsManager().increaseLevel()
                    }
            }
            
            if gameModel.isLose {
                FruitLoseView(game: gameModel, scene: gameModel.scene, level: level)
                    .onAppear {
                        UserDefaultsManager().loseLevel()
                    }
            }
            
            if gameModel.isPause {
                FruitPauseView(game: gameModel, scene: gameModel.scene)
            }
            
            if gameModel.isRules {
                FruitRulesView(game: gameModel, scene: gameModel.scene)
            }
        }
    }
}

#Preview {
    FruitGameView(level: 1)
}

