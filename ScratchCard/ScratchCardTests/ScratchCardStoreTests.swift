//
//  ScratchCardStoreTests.swift
//  ScratchCardStoreTests
//
//  Created by Ondrej Kondek on 06/11/2025.
//

import Foundation
import Testing
@testable import ScratchCard

@MainActor
@Suite("ScratchCardStore tests")
struct ScratchCardStoreTests {
    
    @Test("scratchCard state from .unscratched to .scratched with returned UUID")
    func scratch_success() async throws {
        let wanted = UUID(uuidString: "AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE")!
        let mock = MockCardService()
        mock.generateResult = .success(wanted)
        
        let store = ScratchCardStore(cardService: mock)
        
        #expect(store.state == .unscratched)
        await store.scratchCard()
        
        switch store.state {
        case .scratched(let code):
            #expect(code == wanted)
        default:
            Issue.record("Expected .scratched state")
        }
    }
    
    @Test("scratchCard scratching when already scratched - no change")
    func scratch_when_already_scratched() async throws {
        let mock = MockCardService()
        let store = ScratchCardStore(cardService: mock)
        let existing = UUID()
        store.state = .scratched(code: existing)
        
        await store.scratchCard()
        
        switch store.state {
        case .scratched(let code):
            #expect(code == existing)
        default:
            Issue.record("State should remain .scratched")
        }
    }
    
    @Test("cancelScratch cancels the task and leaves state unchanged")
    func cancel_performing_scratch() async throws {
        let mock = MockCardService()
        mock.generateDelayNanoseconds = 2_000_000_000 // 2s
    
        let store = ScratchCardStore(cardService: mock)
        
        let scratching = Task {
            await store.scratchCard()
        }

        try? await Task.sleep(nanoseconds: 50_000_000) // 50ms
        store.cancelScratch()
        
        await scratching.value
        
        #expect(store.state == .unscratched)
    }
    
    @Test("scratchCard when card is already activated")
    func scratch_activated() async throws {
        let mock = MockCardService()
        let store = ScratchCardStore(cardService: mock)
        store.state = .activated
        
        await store.scratchCard()
        
        #expect(store.state == .activated)
    }
    
    @Test("activateCard sets state to .activated when version > 6.1")
    func activate_success_version_ok() async throws {
        let mock = MockCardService()
        mock.activateResult = .success(VersionResponse(ios: "7.2"))
        let store = ScratchCardStore(cardService: mock)
        let code = UUID()
        store.state = .scratched(code: code)
        
        await store.activateCard(code: code)
        
        #expect(store.state == .activated)
        #expect(store.errorMessage == nil)
    }
    
    @Test("activateCard shows error when version <= 6.1")
    func activate_version_too_low() async throws {
        let mock = MockCardService()
        mock.activateResult = .success(VersionResponse(ios: "6.1"))
        let store = ScratchCardStore(cardService: mock)
        let code = UUID()
        store.state = .scratched(code: code)
        
        await store.activateCard(code: code)
        
        #expect(store.state != .activated)
        let alert = try #require(store.errorMessage)
        #expect(alert.title == "Error")
    }
    
    @Test("activateCard shows error when version string is unparsable")
    func activate_unparsable_version() async throws {
        let mock = MockCardService()
        mock.activateResult = .success(VersionResponse(ios: "invalid"))
        
        let store = ScratchCardStore(cardService: mock)
        let code = UUID()
        store.state = .scratched(code: code)
        
        await store.activateCard(code: code)
        
        #expect(store.state != .activated)
        let alert = try #require(store.errorMessage)
        #expect(alert.title == "Error")
    }
    
    @Test("activateCard shows error when service throws")
    func activate_service_failure() async throws {
        enum TestError: Error { case foo }
        let mock = MockCardService()
        mock.activateResult = .failure(TestError.foo)
        let store = ScratchCardStore(cardService: mock)
        let code = UUID()
        store.state = .scratched(code: code)
        
        await store.activateCard(code: code)
        
        #expect(store.state != .activated)
        let alert = try #require(store.errorMessage)
        #expect(alert.title == "Error")
    }
    
    @Test("activateCard when card is not scratched yet")
    func activate_unscratched() async throws {
        let mock = MockCardService()
        mock.activateResult = .success(VersionResponse(ios: "7.2"))
        let store = ScratchCardStore(cardService: mock)
        store.state = .unscratched
        
        await store.activateCard(code: UUID())
        
        #expect(store.state == .unscratched)
    }
    
    @Test("activateCard when card is already activated")
    func activate_activated() async throws {
        let mock = MockCardService()
        mock.activateResult = .success(VersionResponse(ios: "7.2"))
        let store = ScratchCardStore(cardService: mock)
        store.state = .activated
        
        await store.activateCard(code: UUID())
        
        #expect(store.state == .activated)
    }
}
