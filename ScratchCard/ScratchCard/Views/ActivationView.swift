//
//  ActivationView.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

struct ActivationView: View {
    @Environment(Router.self) private var router
    @Environment(ScratchCardStore.self) private var store

    var body: some View {
        VStack(spacing: 30) {
            Text("Activation View - click to activate scratched card")
            
            if store.state == .activated {
                Text("The code has been successfully activated")
            }

            MenuButton("Activate card") {
                switch store.state {
                case .scratched(let code):
                    Task {
                        await store.activateCard(code: code)
                    }
                default:
                    return
                }
            }
            .disabled(store.state == .activated || store.state == .unscratched)
        }
        .onChange(of: store.errorMessage) { _, alert in
            guard let alert else { return }
            router.showAlert(title: alert.title, message: alert.message)
            store.errorMessage = nil // reset after showing
        }
    }
}

#Preview {
    ActivationView()
        .environment(Router())
        .environment(ScratchCardStore())
}
