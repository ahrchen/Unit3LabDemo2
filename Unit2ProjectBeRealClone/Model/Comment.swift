//
//  Comment.swift
//  Unit2ProjectBeRealClone
//
//  Created by Raymond Chen on 7/17/24.
//

import Foundation

import ParseSwift

struct Comment: ParseObject {
    // These are required by ParseObject
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    // Your own custom properties.
    var username: String?
    var user: User?
    var comment: String?
}
