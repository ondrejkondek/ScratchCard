//
//  HomeView.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

struct HomeView: View {
    @Environment(Router.self) private var router
    @Environment(ScratchCardStore.self) private var store
    
    var body: some View {
        VStack(spacing: 30) {
            scratchCardState()
            
            MenuButton("Scratch Card") {
                router.navigate(to: .scratchCard)
            }
            
            MenuButton("Activate") {
                router.navigate(to: .activation)
            }
        }
    }
    
    private func scratchCardState() -> some View {
        VStack {
            switch store.state {
            case .unscratched:
                Text("Your card is not scratched yet")
            case .scratched(let code):
                Text("Your card has been scratched. Your code: \(code.uuidString)")
            case .activated:
                Text("Your card has been activated")
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(Router())
        .environment(ScratchCardStore())
}
