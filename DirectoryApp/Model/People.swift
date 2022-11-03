//
//  People.swift
//  DirectoryApp
//
//  Created by Aarthi on 02/11/22.
//

import Foundation

struct People {
    var createdAt: String?
    var firstName: String?
    var avatar: String?
    var lastName: String?
    var email: String?
    var jobtitle: String?
    var favouriteColor: String?
    var id: String?
    
    init(p_createdat: String, p_firstname: String, p_avatar: String, p_lastname: String, p_email: String, p_jobtitle: String, p_favouritecolor: String, p_id: String) {
        self.createdAt = p_createdat
        self.firstName = p_firstname
        self.avatar = p_avatar
        self.lastName = p_lastname
        self.email = p_email
        self.jobtitle = p_jobtitle
        self.favouriteColor = p_favouritecolor
        self.id = p_id
    }
}

