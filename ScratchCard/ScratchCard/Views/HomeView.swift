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
        VStack {
            scratchCardState()
            
            Button("Scratch Card") {
                router.navigate(to: .scratchCard)
            }
            .padding(16)
            .border(.black)
        }
    }
    
    private func scratchCardState() -> some View {
        VStack {
            if let code = store.code {
                Text("Your card has been scratched. Your code: \(code.uuidString)")
            } else {
                Text("Your card is not scratched yet")
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(Router())
        .environment(ScratchCardStore())
}
