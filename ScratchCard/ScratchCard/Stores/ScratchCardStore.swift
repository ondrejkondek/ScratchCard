//
//  ScratchCardStore.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

@Observable
final class ScratchCardStore {
    @ObservationIgnored
    private let cardService = ServiceFactory.make(type: CardService.self)

    var state: CardState = .unscratched
    private var scratchTask: Task<Void, Never>?
    
    func scratchCard() async {
        scratchTask = Task {
            guard state == .unscratched else { return }

            do {
                let code = try await cardService.generateId()
                guard !Task.isCancelled else { return }
                state = .scratched(code: code)
            } catch {
                // TODO: error handling + alert
            }
        }
        await scratchTask?.value
    }
    
    func cancelScratch() {
        scratchTask?.cancel()
        scratchTask = nil
    }
}

enum CardState: Equatable {
    case unscratched
    case scratched(code: UUID)
    case activated
    
    static func == (lhs: CardState, rhs: CardState) -> Bool {
        switch (lhs, rhs) {
        case (.unscratched, .unscratched),
             (.activated, .activated):
            return true

        case let (.scratched(code1), .scratched(code2)):
            return code1 == code2

        default:
            return false
        }
    }
}
