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
        .alert(item: $router.alert) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.message ?? ""),
                dismissButton: .default(Text("OK")) {
                    router.dismissAlert()
                }
            )
        }
        .environment(scratchCardStore)
        .environment(router)
    }
}

#Preview {
    ContentView()
}
