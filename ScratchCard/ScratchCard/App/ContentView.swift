//
//  ContentView.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var router = Router()
    @State private var scratchCardStore = ScratchCardStore()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            HomeView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .scratchCard:
                        ScratchCardView()
                    case .activation:
                        ActivationView()
                    }
                }
        }
        .environment(scratchCardStore)
        .environment(router)
    }
}

#Preview {
    ContentView()
}
