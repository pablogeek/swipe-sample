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
    let url = URL(string: "https://gist.githubusercontent.com/pablogeek/987fab1a0293c1f8eb97d2d5095bc1c3/raw/13b5c99502c9c81192ab34af427c2c6d53b5a477/gistfile1.txt")!

    func fetchUserProfiles() async throws -> [UserProfileRepresentable] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let userProfiles = try decoder.decode([UserProfileDTO].self, from: data)
        return userProfiles
    }
}
