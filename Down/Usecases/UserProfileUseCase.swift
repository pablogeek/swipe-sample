//
//  UserProfileUseCase.swift
//  Down
//
//  Created by Pablo Martinez Piles on 2/2/24.
//

import Foundation

@MainActor
class UserProfileUseCase {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func loadUserProfiles() async throws -> [UserProfile] {
        return try await repository.fetchUserProfiles()
            .map { 
                UserProfile(
                    userId: $0.userId,
                    name: $0.name,
                    age: $0.age,
                    profilePicUrl: $0.profilePicUrl,
                    loc: $0.loc,
                    aboutMe: $0.aboutMe)
            }
    }
}
