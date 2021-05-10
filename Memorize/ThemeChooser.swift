//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Григорий Кривякин on 30.04.2021.
//

import SwiftUI


struct ThemeChooser: View {
    @EnvironmentObject var themesStore: ThemesStore
    
    @State private var editMode: EditMode = .inactive
    @State private var showTitleScreen: Bool = true

    var body: some View {
        NavigationView {
//            List {
//                ForEach(themesStore.themes) { theme in
//                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(with: theme))) {
//                        ThemeListItem(theme: theme)
//                    }
//                }
//                .onDelete(perform: { themesStore.themes.remove(atOffsets: $0) })
//            }
            List() {
                ForEach(themesStore.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(with: theme))) {
                        ThemeListItem(theme: theme)
                    }
                }
                .onDelete(perform: { themesStore.themes.remove(atOffsets: $0) })
            }
            .navigationBarTitle("Choose a theme")
            .navigationBarItems(leading: Button(action: { withAnimation(.easeInOut, themesStore.addNewTheme) },
                                                label: { Text("+").font(.largeTitle)}),
                                trailing: EditButton())
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.editMode, $editMode)
        }
    }
}
