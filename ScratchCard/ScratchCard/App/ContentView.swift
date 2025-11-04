//
//  ContentView.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            HomeView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .scratchCard:
                        ScratchCardView()
                    }
                }
        }
        .environment(router)
    }
}

#Preview {
    ContentView()
}
