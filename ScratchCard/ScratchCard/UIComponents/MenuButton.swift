//
//  MenuButton.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 05/11/2025.
//

import SwiftUI

struct MenuButton: View {
    let title: String
    let action: () -> Void
    
    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(title, action: action)
            .frame(minWidth: 200)
            .padding(10)
            .border(.black)
    }
}
