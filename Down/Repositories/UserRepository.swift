//
//  UserRepository.swift
//  Down
//
//  Created by Pablo Martinez Piles on 2/2/24.
//

import Foundation

protocol UserRepository {
    func fetchUserProfiles() async throws -> [UserProfileRepresentable]
}

class UserRepositoryImpl: UserRepository {
    let url = URL(string: "https://raw.githubusercontent.com/downapp/sample/main/sample.json")!

    func fetchUserProfiles() async throws -> [UserProfileRepresentable] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let userProfiles = try decoder.decode([UserProfileDTO].self, from: data)
        return userProfiles
    }
}
