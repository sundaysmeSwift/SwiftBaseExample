//
//  API.swift
//  SwiftBaseExample
//
//  Created by administrator on 2020/12/7.
//  Copyright © 2020 administrator. All rights reserved.
//

import Foundation
import Moya


let apiProvider = MoyaProvider<API>()

enum API {
    case getUserLogin
    case register(country: String, mobile: String, pwd: String, verifycode: String)
    
}


extension API: TargetType {
    var baseURL: URL {
        switch self {
        case .getUserLogin:
            return URL(string: "\(URLManager.loginUrl)")!
        case .register:
            return URL(string: "\(URLManager.regesterUrl)")!
        default:
            return URL(string: "\(URLManager.defaultUrl)xxxx/")!
        }
        
    }
    var path: String {
        switch self {
        case .getUserLogin:
            return "api/common/currencies"
        case .register:
            return "api/common/symbols"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        case .getUserLogin:
            return .get
        default:
            return .get
            
        }
    }
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case let .register(country: country, mobile: mobile, pwd: password, verifycode: verifycode):
            return .requestParameters(parameters: ["country": country, "mobile": mobile, "pwd": password,"verifycode":verifycode].digital_signature(), encoding: getEncoding())
        default:
            return .requestParameters(parameters: Dictionary<String,String>(), encoding: getEncoding())
        }
    }

    var headers: [String : String]? {
        var param = [String: String]()
        if NSLocalizedString("language", comment: "") == "cn"{
            param =  ["Language": "zh_CN","Platform":"ios"]
        }else{
            param = ["Language": "en_US","Platform":"ios"]
        }
        switch self {
        case .getUserLogin:
            
            return param;
        case .register:
            param["sessionKey"] = "value"
            return param;
            
        default:
            return param;
            
            
        }
    }
    
    func getEncoding()-> ParameterEncoding {
        return self.method == .get ?  URLEncoding.queryString : URLEncoding.default
    }
}



extension Dictionary where Key: ExpressibleByStringLiteral, Value: ExpressibleByStringLiteral {
    func digital_signature() -> Dictionary<String, String> {
        return ["key" : "value"]
    }
    
}



import SwiftyJSON

extension Data {
    func toJSON()-> JSON {
        return JSON(self)
    }
}
extension JSON {
   
    func process(completion:(JSON)-> Void){
        completion(self)
    }
    
    func loginResponseMsg(status:Int,completion: (JSON)-> Void) {
        
        
    }
    
    func processResponse(status:Int,completion: (JSON)-> Void) {
        
        
    }
}
