//
//  ThemesStore.swift
//  Memorize
//
//  Created by Григорий Кривякин on 02.05.2021.
//

import Foundation
import SwiftUI
import Combine

class ThemesStore: ObservableObject {
    @Published var themes = loadThemes() ?? createDefaultThemes()
    private var autosave: AnyCancellable?
    
    init() {
        autosave = $themes.sink { themes in
            themes.forEach { theme in print("Theme .\(theme.id.uuidString) is saved")
                UserDefaults.standard.setValue(themes.map { $0.id.uuidString } , forKey: "EmojiMemoriGame.ThemesId")
                UserDefaults.standard.setValue(theme.json, forKey: "EmojiMemoryGame.Themes.\(theme.id.uuidString)")
            }
        }
    }
    
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
            themes[index].numberOfPairs = min(themes[index].emojis.count, themes[index].numberOfPairs)
        }
    }
    
    func changeColor(of theme: Theme, by color: Color) {
        if let index = themes.firstIndex(of: theme) {
            themes[index].color = color
        }
    }
    
    func changeNumberOfPairs(of theme: Theme, by numberOfPairs: Int) {
        if let index = themes.firstIndex(of: theme) {
            themes[index].numberOfPairs = min(numberOfPairs, themes[index].emojis.count)
        }
    }
    
    func renameTheme(_ theme: Theme, with name: String) {
        if let index = themes.firstIndex(of: theme) {
            themes[index].name = name
        }
    }
    
    
    static private func loadThemes() -> [Theme]? {
        print("Try to load themes")
        let themesId: [String]? = UserDefaults.standard.stringArray(forKey: "EmojiMemoriGame.ThemesId")
        var themes = [Theme]()
        themesId?.forEach { uuidString in
            let themeData = UserDefaults.standard.data(forKey: "EmojiMemoryGame.Themes.\(uuidString)")
            if let theme = Theme(json: themeData) { themes.append(theme)
                print("Theme .\(uuidString) loaded")
            }
        }
        //var themes = [Theme]()
        return themes.isEmpty ? nil : themes
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
        print("Create default themes")
        return themes
    }

}
