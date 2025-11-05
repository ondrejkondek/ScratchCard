//
//  ScratchCardStore.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

@Observable
final class ScratchCardStore {
    var state: CardState = .unscratched
    var errorMessage: AlertData?
    private var scratchTask: Task<Void, Never>?

    @ObservationIgnored
    private let cardService = ServiceFactory.make(type: CardService.self)
    
    func scratchCard() async {
        scratchTask = Task {
            guard state == .unscratched else { return }

            do {
                let code = try await cardService.generateId()
                guard !Task.isCancelled else { return }
                state = .scratched(code: code)
            } catch {
                // TODO: error handling + alert
                // No handling needed - api call is simulated and response is guaranteed
            }
        }
        await scratchTask?.value
    }
    
    func cancelScratch() {
        scratchTask?.cancel()
        scratchTask = nil
    }
    
    func activateCard(code: UUID) {
        Task {
            do {
                let version = try await cardService.activateCard(code: code)
                handleVersionResponse(version)
            } catch {
                handleActivationError()
            }
        }
    }
    
    private func handleVersionResponse(_ response: VersionResponse) {
        if let version = Double(response.ios) {
            if version > 6.1 {
                state = .activated
            } else {
                handleActivationError()
            }
        } else {
            handleActivationError()
        }
    }
    
    private func handleActivationError() {
        errorMessage = AlertData(title: "Error", message: "Unable to activate your code")
    }
}
