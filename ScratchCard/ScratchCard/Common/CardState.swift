//
//  CardState.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 05/11/2025.
//

import Foundation

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
