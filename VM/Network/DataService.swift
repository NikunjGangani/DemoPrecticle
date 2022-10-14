//
//  DataService.swift
//  VM
//
//  Created by Nikunj Gangani on 14/10/22.
//

import UIKit
import SwiftyJSON
import Alamofire

class DataService {
    
    static func peopleList(failure:@escaping APICompletionBlock, success:@escaping (_ message:String,_ items:[People]) -> Void){
        BaseAPIManager.shared.request(method: .get, url: APIEndPoint.people,parameters:[:],needUserToken: true, failure: failure) { (response) in
            let responseData = response.response
            let items = responseData.arrayValue.map({People($0)})
            success(response.message,items)
        }
    }
    
    static func roomList(failure:@escaping APICompletionBlock, success:@escaping (_ message:String,_ items:[Room]) -> Void){
        BaseAPIManager.shared.request(method: .get, url: APIEndPoint.rooms,parameters:[:],needUserToken: true, failure: failure) { (response) in
            let responseData = response.response
            let items = responseData.arrayValue.map({Room($0)})
            success(response.message,items)
        }
    }
}
