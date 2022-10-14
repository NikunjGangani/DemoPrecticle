//
//  People.swift
//  VM
//
//  Created by Nikunj Gangani on 14/10/22.
//

import UIKit
import SwiftyJSON

struct People {
    var id = ""
    var email = ""
    var avatar = ""
    var firstName = ""
    var lastName = ""
    var favouriteColor = ""
    var jobtitle = ""
    var createdAt = ""
    
    init(_ json: JSON) {
        id = json["id"].stringValue
        email = json["email"].stringValue
        avatar = json["avatar"].stringValue
        firstName = json["firstName"].stringValue
        lastName = json["lastName"].stringValue
        favouriteColor = json["favouriteColor"].stringValue
        jobtitle = json["jobtitle"].stringValue
        createdAt = json["createdAt"].stringValue
    }
    
}
