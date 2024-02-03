//
//  UserProfile.swift
//  Down
//
//  Created by Pablo Martinez Piles on 2/2/24.
//

import Foundation

class UserProfile: ObservableObject, UserProfileRepresentable, Identifiable {
    let userId: Int
    let name: String
    let age: Int
    let profilePicUrl: String
    let loc: String
    let aboutMe: String
    var id: Int { userId }
    
    @Published var state: UserProfileState = .none
    
    init(
        userId: Int,
        name: String,
        age: Int,
        profilePicUrl: String,
        loc: String,
        aboutMe: String
    ) {
        self.userId = userId
        self.name = name
        self.age = age
        self.profilePicUrl = profilePicUrl
        self.loc = loc
        self.aboutMe = aboutMe
        self.state = state
    }
}
