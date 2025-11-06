//
//  ScratchCardView.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

struct ScratchCardView: View {
    @Environment(Router.self) private var router
    @Environment(ScratchCardStore.self) private var store
    
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            Button {
                Task {
                    isLoading = true
                    await store.scratchCard()
                    isLoading = false
                }
            } label: {
                if !isLoading {
                    scratchCard
                } else {
                    ProgressView("Scratching...")
                        .progressViewStyle(.circular)
                }
            }
        }
        .onDisappear {
            store.cancelScratch()
        }
    }
    
    var scratchCard: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(store.state != .unscratched ? Color.blue.opacity(0.8) : Color.green.opacity(0.8))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black, lineWidth: 2)
            )
            .frame(width: 300, height: 150)
            .overlay(
                VStack {
                    switch store.state {
                    case .scratched(let code):
                        Text(code.uuidString)
                            .foregroundStyle(.black)
                    case .activated:
                        Text("Activated")
                            .foregroundStyle(.black)
                    default:
                        Text("Click to scratch")
                            .foregroundStyle(.black)
                    }
                }
            )
    }
}


#Preview {
    ScratchCardView()
        .environment(Router())
        .environment(ScratchCardStore())
}
