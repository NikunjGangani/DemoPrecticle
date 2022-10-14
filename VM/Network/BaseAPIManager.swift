//
//  BaseAPIManager.swift
//  VM
//
//  Created by Nikunj Gangani on 14/10/22.
//

import UIKit
import SwiftyJSON
import Alamofire

typealias APICompletionBlock = (_ response:APIResponse) -> Void

struct APIResponse {
    var success = false
    var message = ""
    var response: JSON
    
    static func createAPIResponse(_ success:Bool,_ message:String = "", _ response:JSON = JSON.null) -> APIResponse {
        return APIResponse.init(success: success, message: message, response: response)
    }
    
    static func createSuccessAPIResponse(_ message:String = "",_ response:JSON = JSON.null) -> APIResponse {
        return APIResponse.init(success: true, message: message, response: response)
    }
    
    static func createFailureAPIResponse(_ message:String = "", _ response:JSON = JSON.null) -> APIResponse {
        return  APIResponse.init(success: false, message: message, response: response)
    }
}

class BaseAPIManager {
    static var shared = BaseAPIManager()
     var manager = Alamofire.Session.default
     private init() {
        // self.enableCertificatePinning()
     }
    
    func request (method : HTTPMethod, url:APIEndPoint, parameters:Parameters = [:] ,pathComponent:String = "",isMwServer:Bool = false ,isAppleServer:Bool = false ,needUserToken:Bool = false,failure:@escaping APICompletionBlock, success:@escaping APICompletionBlock) {
       
       let queue = DispatchQueue(label: "com.VM", qos: .utility, attributes: [.concurrent])
       let configuration = URLSessionConfiguration.default
       configuration.timeoutIntervalForRequest = 60
       configuration.timeoutIntervalForResource = 60
       
       var absoluteUrl = APIContants.apiEndPoint + "/" + url.rawValue + pathComponent
       var authorization = "Bearer \("")"
       var param:Parameters? = parameters
       
       if method == .get {
           if let urlParameters = param {
               if !(urlParameters.isEmpty) {
                   absoluteUrl.append("?")
                   var array:[String] = []
                   let _ = urlParameters.map { (key, value) -> Bool in
                       let str = key + "=" +  String(describing: value)
                       array.append(str)
                       return true
                   }
                   absoluteUrl.append(array.joined(separator: "&"))
               }
           }
           
           param = nil
           
           authorization = "Bearer \("")"
       }
        
        var headers = HTTPHeaders()
        headers = ["content-type": "application/json",
                    "Accept": "application/json"]
       
       manager.request(absoluteUrl, method: method, parameters: param, encoding: JSONEncoding.default, headers:headers).responseJSON( queue: queue, options: .allowFragments,completionHandler: { response in
           if let status = response.response?.statusCode,let json = response.value {
               switch(status) {
               case 200,201,1000,2000:
                   
                   let responseJSON = JSON(json)
                   print(responseJSON)
                   let statusCode = responseJSON["statusCode"].intValue
                   let message = responseJSON["message"].stringValue
                   if  status == APIContants.successCode
                   {
                       DispatchQueue.main.async {
                           success(APIResponse.createSuccessAPIResponse(message,responseJSON))
                       }
                   }
                   else if  statusCode == APIContants.unauthenticated
                   {
                       DispatchQueue.main.async {
                           success(APIResponse.createSuccessAPIResponse(message,responseJSON))
                       }
                   }
                   else if  statusCode == APIContants.tokenExpire
                   {
                       DispatchQueue.main.async {
                           failure(APIResponse.createFailureAPIResponse("Session Expired!"))
                       }
                   }
                   else
                   {
                       DispatchQueue.main.async {
                           failure(APIResponse.createFailureAPIResponse(message, responseJSON))
                       }
                   }
                   
               case 401:
                   let errorMsg = self.getFailureMessage(response: response)
                   DispatchQueue.main.async {
                       failure(APIResponse.createFailureAPIResponse(errorMsg))
                   }
                   
               default:
                   let errorMsg = self.getFailureMessage(response: response)
                   DispatchQueue.main.async {
                       failure(APIResponse.createFailureAPIResponse(errorMsg))
                   }
               }
           } else {
               DispatchQueue.main.async {
                   failure(APIResponse.createFailureAPIResponse("Not found!"))
               }
           }
       })
   }
    
   
    func getFailureMessage(response:AFDataResponse<Any>) -> String {
       var errorMsg = "Not found!"
       if let resultDictionary = response.value as? [String : Any] {
           if let message = resultDictionary["message"] as? String {
               errorMsg = message
           }
       }
       return errorMsg
   }
}
