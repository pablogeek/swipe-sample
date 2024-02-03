//
//  UserProfileRepresentable.swift
//  Down
//
//  Created by Pablo Martinez Piles on 3/2/24.
//

import Foundation

protocol UserProfileRepresentable {
    var userId: Int { get }
    var name: String { get }
    var age: Int { get }
    var profilePicUrl: String { get }
    var loc: String { get }
    var aboutMe: String { get }
}
