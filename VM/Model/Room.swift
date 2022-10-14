//
//  Room.swift
//  VM
//
//  Created by Nikunj Gangani on 14/10/22.
//

import UIKit
import SwiftyJSON

struct Room {
    var id = ""
    var isOccupied = false
    var maxOccupancy = ""
    var createdAt = ""
    
    init(_ json: JSON) {
        id = json["id"].stringValue
        isOccupied = json["isOccupied"].boolValue
        maxOccupancy = json["maxOccupancy"].stringValue
        createdAt = json["createdAt"].stringValue
    }
}
