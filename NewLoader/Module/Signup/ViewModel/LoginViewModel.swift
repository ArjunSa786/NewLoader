

import Foundation
import Alamofire

@objc protocol LoginVCDelegate: ActivityIndicatorDelegate{
    
}

class LoginViewModel {
    
    weak var delegate: LoginVCDelegate!
     var newsdata : NewsRootClass?

    func RegisterAPICall(name: String,mobileno: String,emailaddress: String, unifiednumber: String, onSuccess: @escaping (Bool,String) -> (), onFailure: @escaping (String) -> ()){
           
        let postParameter: [String: Any] = ["eid": "123456", "idbarahno": "123456", "name": name, "mobileno": mobileno, "emailaddress": emailaddress, "unifiednumber": unifiednumber, "local" : "en"]
           self.delegate.startActivityIndicator()
        
           print(postParameter)
           do {
               try Service.serviceRequest(path: SignupAPI, method: HTTPMethod.post, parameters: postParameter, Jsonencoding: false,  onCompletion: { status, message, value in
                   self.delegate.stopActivityIndicator()
                   
                   guard status else {
                       onFailure(message)
                       return
                   }

                   onSuccess(value["success"].boolValue, value["message"].stringValue)
               })
           } catch {
           }
       }
    
    func GetNewsAPICall(onSuccess: @escaping (Int,String) -> (), onFailure: @escaping (String) -> ()){
           
        let postParameter: [String: Any] = ["consumer-key": "mobile_dev_temp", "consumer-secret": "20891a1b4504ddc33d42501f9c8d2215fbe85008"]
           self.delegate.startActivityIndicator()
        
           print(postParameter)
           do {
               try Service.serviceRequest(path: GetNewsAPI, method: HTTPMethod.get, parameters: postParameter, Jsonencoding: false,  onCompletion: { status, message, value in
                   self.delegate.stopActivityIndicator()
                   
                   guard status else {
                       onFailure(message)
                       return
                   }

                    let rootclass = NewsRootClass.init(fromJson: value)
                    self.newsdata = rootclass
                   onSuccess(value["code"].intValue, value["success"].stringValue)
               })
           } catch {
           }
       }

}
