
import Foundation
import SwiftyJSON

class NewsRootClass{

    var payload : [Payload]!
    var success : Bool!

    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        payload = [Payload]()
        let payloadArray = json["payload"].arrayValue
        for payloadJson in payloadArray{
            let value = Payload(fromJson: payloadJson)
            payload.append(value)
        }
        success = json["success"].boolValue
    }
}

class Payload{

    var date : String!
    var descriptionField : String!
    var image : String!
    var title : String!

    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        date = json["date"].stringValue
        descriptionField = json["description"].stringValue
        image = json["image"].stringValue
        title = json["title"].stringValue
    }
}

