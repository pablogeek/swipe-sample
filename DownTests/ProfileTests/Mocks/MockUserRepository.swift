//
//  MockUserRepository.swift
//  DownTests
//
//  Created by Pablo Martinez Piles on 2/2/24.
//

import XCTest
@testable import Down

class MockUserRepository: UserRepository {
    var shouldReturnError = false
    var fetchUserProfilesCalled = false

    func fetchUserProfiles() async throws -> [UserProfileRepresentable] {
        fetchUserProfilesCalled = true
        if shouldReturnError {
            throw URLError(.badServerResponse)
        } else {
            return [UserProfile(userId: 0, name: "Pablo", age: 35, profilePicUrl: "https://example.com/image.jpg", loc: "Spain", aboutMe: "iOS Engineer"), UserProfile(userId: 0, name: "Pablo", age: 35, profilePicUrl: "https://example.com/image.jpg", loc: "Spain", aboutMe: "iOS Engineer")]
        }
    }
}
