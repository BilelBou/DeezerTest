//
//  PlayerControlButton.swift
//  DeezerExerciseSwiftUI
//
//  Created by Bilel Bouricha on 18/01/2023.
//

import SwiftUI

struct PlayerControlButton: View {
    var systemName: String = "play"
    var fontSize: CGFloat = 24
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.system(size: fontSize))
                .foregroundColor(Color.secondary)
        }
    }
}

struct PlayerControlButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControlButton(action: {})
    }
}
