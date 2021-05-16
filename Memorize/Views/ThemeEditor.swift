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
    @State private var selectedColor: Color = Color.clear
    @State private var selectedNumberOfPairs: Int = 0
    private var theme: Theme
    
    @State private var showRemovingEmojisAlert = false
        
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

                    ColorPicker("Theme color", selection: $selectedColor)

                    Stepper(value: $selectedNumberOfPairs, in: 2...theme.emojis.count,
                            onEditingChanged: { began in
                                if !began {
                                    themesStore.changeNumberOfPairs(of: theme, by: selectedNumberOfPairs)
                                }
                            }, label: { Text("Number of pairs: \(selectedNumberOfPairs)") } )
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
                                    if theme.emojis.count == 2 {
                                        showRemovingEmojisAlert = true
                                        return
                                    }
                                    themesStore.removeEmoji(emoji, from: theme)
                                    selectedNumberOfPairs = min(selectedNumberOfPairs, theme.emojis.count - 1)
                                }
                                .alert(isPresented: $showRemovingEmojisAlert) {
                                    return Alert(title: Text("Remove error"),
                                                 message: Text("Theme can not contain less than 2 emojis."),
                                                 dismissButton: .default(Text("OK")))
                                }
                    }
                    
                }
            }
            .onAppear {
                themeName = theme.name
                selectedColor = theme.color
                selectedNumberOfPairs = theme.numberOfPairs
            }
            .onDisappear {
                themesStore.changeColor(of: theme, by: selectedColor)
            }
        }
    }
    
}
