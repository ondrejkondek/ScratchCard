//
//  ActivationView.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

struct ActivationView: View {
    @Environment(Router.self) private var router
    
    let manager: NetworkManager = NetworkManager()

    var body: some View {
        Text("Activation View")
            .onAppear {
                Task {
                    do {
                        let request = ApiEndpoints.activate(code: UUID()).request
                        let model = try await self.manager.request(request, body: VersionResponse.self)
                        print(model)
                    } catch {
                        print("error: \(error)")
                    }
                }
            }
    }
}

#Preview {
    ActivationView()
        .environment(Router())
}
