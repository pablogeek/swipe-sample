//
//  UserProfileDTO.swift
//  Down
//
//  Created by Pablo Martinez Piles on 3/2/24.
//

import Foundation

struct UserProfileDTO: Codable, UserProfileRepresentable {
    let userId: Int
    let name: String
    let age: Int
    let profilePicUrl: String
    let loc: String
    let aboutMe: String
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case age
        case loc
        case aboutMe = "about_me"
        case profilePicUrl = "profile_pic_url"
    }
}
