//
//  ScratchCardView.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

struct ScratchCardView: View {
    @Environment(Router.self) private var router
    
    var body: some View {
        Text("scratch")
    }
}

#Preview {
    ScratchCardView()
        .environment(Router())
}
