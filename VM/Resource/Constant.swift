//
//  Constant.swift
//  VM
//
//  Created by Nikunj Gangani on 14/10/22.
//

import UIKit


enum APIEndPoint: String {
    case rooms = "rooms"
    case people = "people"
}

struct APIContants
{
    static let token = ""
    static let uniqueKey = ""
    static let successCode = 200
    static let errorCode = 200
    static let unauthenticated = 300
    static let tokenExpire = 500
    static var apiDomain: String {
        return "https://61e947967bc0550017bc61bf.mockapi.io"
    }
    static var apiEndPoint: String {
        return "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/"
    }
 
}
