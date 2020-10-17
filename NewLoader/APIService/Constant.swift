

import Foundation
import CoreLocation
import UIKit

enum HTTPType: String {
    case Get = "GET"
    case Post = "POST"
}

enum Environment: String {
    case Development = "dev"
}

enum ApiRequestType: Int {
    case Synchronous
    case Asynchronous
}

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
let USERDEFAULTS = UserDefaults.standard
let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
var Service = BaseService()

let ServerResponseFailureMessage = "Server not Response,Please try again."
let ServerNotFoundMessage = "Server Not found"

let environment = Environment.Development
var BASE_URL = "https://api.qa.mrhe.gov.ae/mrhecloud/v1.4/api/"

var alertmessage = false

var APP_BASEURL: String {
    get {
        switch environment {
        case .Development:
            return "https://api.qa.mrhe.gov.ae/mrhecloud/v1.4/api/"
        }
    }
}

let SignupAPI = APP_BASEURL + "iskan/v1/certificates/towhomitmayconcern"
let GetNewsAPI = APP_BASEURL + "public/v1/news?local=en"
