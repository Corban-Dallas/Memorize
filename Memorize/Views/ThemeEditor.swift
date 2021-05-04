//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Григорий Кривякин on 02.05.2021.
//

import SwiftUI

struct ThemeEditor: View {
    @EnvironmentObject var themesStore: ThemesStore
    @State private var themeName: String = ""
    @State private var emojisToAdd: String = ""
    private var theme: Theme
    
    init(edit theme: Theme) {
        self.theme = theme
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Theme editor").font(.title).bold().padding()
            Divider()
            Form {
                Section {
                    TextField("Theme name", text: $themeName, onEditingChanged: { began in
                        if !began {
                            themesStore.renameTheme(theme, with: themeName)
                        }
                    })
                    TextField(
                        "Choose new emojis",
                        text: $emojisToAdd,
                        onEditingChanged: { began in
                            if !began {
                                themesStore.addEmojis(emojisToAdd, to: theme)
                                emojisToAdd = ""
                            }
                        })
                }
                Section(header: Text("Remove")) {
                    Grid(theme.emojis, id: \.self) { emoji in
                            Text(emoji)
                                .onTapGesture {
                                    themesStore.removeEmoji(emoji, from: theme)
                                }
                    }
                }
            }
            .onAppear {
                themeName = theme.name
            }
        }
    }
    
}
