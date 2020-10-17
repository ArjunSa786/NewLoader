

import Foundation
import Alamofire
import SwiftyJSON

typealias ServiceResponse = (Bool, JSON) -> Void
typealias StatusServiceResponse = (Bool, String, JSON) -> Void

class BaseService {

    func serviceRequest(path: String, method: HTTPMethod, parameters: Parameters,  Jsonencoding : Bool, onCompletion: @escaping StatusServiceResponse) throws {
        let url = try path.asURL()

        var contains : Bool = false
        var header = [String : String]()
        if Jsonencoding == true {
            header = ["Content-Type": "application/json","consumer-key": "mobile_dev_temp", "consumer-secret": "20891a1b4504ddc33d42501f9c8d2215fbe85008"]
            contains = true
        } else {
            header = ["Content-Type": "application/x-www-form-urlencoded","consumer-key": "mobile_dev_temp", "consumer-secret": "20891a1b4504ddc33d42501f9c8d2215fbe85008"]
            contains = false
        }
 
        print("Path = \(path)\nParameter = \(Parameters())")
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: (contains) ? JSONEncoding.default : URLEncoding.default  , headers: header)
            .responseJSON { response in
 
                let strOutput = String(data : response.data!, encoding : String.Encoding.utf8)
                print("Response = \(response)")
                do{
                    if let json = strOutput?.data(using: String.Encoding.utf8){
                        if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as?  Dictionary<String,AnyObject>{
                            print(jsonData)
                            onCompletion(true, JSON(jsonData)["Message"].stringValue, JSON(jsonData))
                        } else {
                            let statusCode = response.response?.statusCode
                            let fail: NSDictionary?
                            var message = ""
                            if statusCode == 404 {
                                fail =  ["reason": "\(ServerNotFoundMessage)"]
                                message = ServerNotFoundMessage
                            } else {
                                fail =  ["reason": "\(ServerResponseFailureMessage):\(String(describing: statusCode))" as Any]
                                message = ServerResponseFailureMessage
                            }
                            onCompletion(false, message, JSON(fail!))
                        }
                     }
                }catch {
                    let statusCode = response.response?.statusCode
                    let fail: NSDictionary?
                    var message = ""
                    if statusCode == 404 {
                        fail =  ["reason": "\(ServerNotFoundMessage)"]
                        message = ServerNotFoundMessage
                    } else {
                        fail =  ["reason": "\(ServerResponseFailureMessage):\(String(describing: statusCode))" as Any]
                        message = ServerResponseFailureMessage
                    }
                    onCompletion(false, "\(message)", JSON(fail!))
                    print(error.localizedDescription)
                 }
          }
     }

    func serviceGETRequest(path: String , onCompletion: @escaping StatusServiceResponse) throws {
        let url = try path.asURL()
        Alamofire.request(url).responseJSON { response in
            
            print(response.result.value as Any)
            switch response.result
            {
            case .success:
                if let value = response.result.value {
                    onCompletion(true, JSON(value)["message"].stringValue, JSON(value))
                }
            case .failure:
                let statusCode = response.response?.statusCode
                let fail: NSDictionary?
                var message = ""
                if statusCode == 404 {
                    fail =  ["reason": "\(ServerNotFoundMessage)"]
                    message = ServerNotFoundMessage
                } else {
                    fail =  ["reason": "\(ServerResponseFailureMessage):\(String(describing: statusCode))" as Any]
                    message = ServerResponseFailureMessage
                }
                onCompletion(false, "\(message)", JSON(fail!))
            }
            
        }
     }

}
