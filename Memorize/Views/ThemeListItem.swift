//
//  ThemeListItem.swift
//  Memorize
//
//  Created by Григорий Кривякин on 02.05.2021.
//

import SwiftUI

struct ThemeListItem: View {
    let theme: Theme
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(theme.name)
                .foregroundColor(theme.color)
            HStack {
                ForEach(theme.emojis, id: \.self) { emoji in
                    Text(emoji)
                }
            }
        }
        .padding(.horizontal)
    }
}
