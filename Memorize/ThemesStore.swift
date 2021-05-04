//
//  ThemesStore.swift
//  Memorize
//
//  Created by Григорий Кривякин on 02.05.2021.
//

import Foundation
import SwiftUI

class ThemesStore: ObservableObject {
    @Published var themes = createDefaultThemes()
    
    func addNewTheme() -> Void {
        themes.append(Theme(name: "Untitled",
                            emojis: ["👻", "👽", "🐭", "🐹", "👑", "🧳"],
                            numberOfPairs: 6,
                            color: Color.orange))
    }
    func addEmojis(_ emojis: String, to theme: Theme) {
        if let index = themes.firstIndex(of: theme) {
            emojis.map { String($0) }.forEach { emoji in
                themes[index].emojis.append(emoji)
            }
        }
    }
    func removeTheme(_ theme: Theme) -> Void {
        themes.removeAll(where: {$0.id == theme.id})
    }
    func removeEmoji(_ emoji: String, from theme: Theme) {
        if let index = themes.firstIndex(of: theme) {
            themes[index].emojis.removeAll(where: { $0 == emoji })
        }
    }
    
    
    func renameTheme(_ theme: Theme, with name: String) {
        if let index = themes.firstIndex(of: theme) {
            themes[index].name = name
        }
    }
    
    static func createDefaultThemes() -> [Theme] {
        var themes = [Theme]()
        themes.append(Theme(name: "Hallowen",
                            emojis: ["👻", "👽", "👹", "😈", "💀", "🎃"],
                            numberOfPairs: 6,
                            color: Color.orange))
        themes.append(Theme(name: "Animals",
                            emojis: ["🐶","🐱", "🐭", "🐹", "🦊"],
                            numberOfPairs: 5,
                            color: Color.blue))
        themes.append(Theme(name: "Items",
                            emojis: ["💍", "👠", "🪖", "👑", "🧳"],
                            numberOfPairs: 5,
                            color: Color.red))
        return themes
    }

}
