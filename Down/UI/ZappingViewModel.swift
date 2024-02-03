//
//  ZappingViewModel.swift
//  Down
//
//  Created by Pablo Martinez Piles on 2/2/24.
//

import SwiftUI
import Combine

@MainActor
class ZappingViewModel: ObservableObject {
    
    enum SwipeDirection {
        case up
        case down
    }
    
    @Published var profiles: [UserProfile] = []
    @Published var currentIndex = 0
    private let useCase: UserProfileUseCase
    
    @Published var swippingDirection: SwipeDirection?

    init(useCase: UserProfileUseCase) {
        self.useCase = useCase
    }

    func loadProfiles() async {
        do {
            self.profiles = try await useCase.loadUserProfiles()
        } catch {
            // Handle errors
            print(error)
        }
    }
    
    func onChangedSwipe(translation: CGSize) {
        swippingDirection = translation.height < 0 ? .up : .down
    }
    
    func handleAction(direction: SwipeDirection, for profile: UserProfile) async {
        profile.state = direction == .up ? .hookup : .date
        self.swippingDirection = nil
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        moveToNextProfile()
    }
    
    func handleSwipe(index: Int) {
        self.swippingDirection = nil
    }
    
    private func moveToNextProfile() {
        if currentIndex < profiles.count - 1 {
            currentIndex += 1
        }
    }
    
    private func moveToPreviousProfile() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
}
