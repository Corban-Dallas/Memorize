//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Григорий Кривякин on 23.02.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    var theme: Theme {
        didSet {
            let json = String(data: theme.json!, encoding: .utf8)
            print("theme.json = \(json!.utf8)")
        }
    }
    @Published private var model: MemoryGame<String>
    
    init(with theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(with: self.theme)
    }
     
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: theme.emojis.count) { pairIndex in
            theme.emojis[pairIndex]
        }
    }

    // MARK: - Acess to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    

}


