//
//  ScratchCardStore.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

@Observable
final class ScratchCardStore {
    var code: UUID? = nil
    
    func generateCode() {
        // TODO: API Call
        guard code == nil else { return }
        code = UUID()
    }
}
