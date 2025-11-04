//
//  HomeView.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

struct HomeView: View {
    @Environment(Router.self) private var router
    
    var body: some View {
        VStack {
            Text("Hello")
            Button("Scratch Card") {
                router.navigate(to: .scratchCard)
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(Router())
}
