//
//  Rooms.swift
//  DirectoryApp
//
//  Created by Aarthi on 02/11/22.
//

import Foundation

struct Rooms {
    var createdAt: String?
    var isOccupied: Bool?
    var maxOccupancy: Int64?
    var id: String?
    
    init(r_createdat: String, r_isoccupied: Bool, r_maxoccupancy: Int64, r_id: String) {
        self.createdAt = r_createdat
        self.isOccupied = r_isoccupied
        self.maxOccupancy = r_maxoccupancy
        self.id = r_id
        
    }
}
