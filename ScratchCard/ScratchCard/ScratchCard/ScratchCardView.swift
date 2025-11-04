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
    
    var body: some View {
        VStack {
            Button {
                store.generateCode()
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(store.code != nil ? Color.green.opacity(0.8) : Color.blue.opacity(0.8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 2)
                    )
                    .frame(width: 300, height: 150)
                    .overlay(
                        VStack {
                            if let code = store.code?.uuidString {
                                Text(code)
                            }
                            else {
                                Text("Click to scratch")
                                    .foregroundStyle(.black)
                            }
                        }
                    )
            }
        }
    }
}


#Preview {
    ScratchCardView()
        .environment(Router())
        .environment(ScratchCardStore())
}
