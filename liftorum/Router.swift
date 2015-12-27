import Alamofire
import SwiftyJSON


enum Router: URLRequestConvertible {
    
    case Login([String: AnyObject])
    case GetLift(id: Int)
    case GetLifts(page: Int)
    case CreateVideo()
    case CreateLift([String: AnyObject])
    case CreateComment([String: AnyObject])
    case CreateUser([String: AnyObject])
    
    var method: Alamofire.Method {
        switch self {
        case .Login:
            return .POST
        case .GetLift:
            return .GET
        case .GetLifts:
            return .GET
        case .CreateVideo:
            return .POST
        case .CreateLift:
            return .POST
        case .CreateComment:
            return .POST
        case .CreateUser:
            return .POST
        }
    }

    var path: String {
        switch self {
        case .Login:
            return "/auth"
        case .GetLift(let id):
            return "/api/lift/\(id)"
        case .GetLifts:
            return "/api/lift"
        case .CreateVideo:
            return "/api/video"
        case .CreateLift:
            return "/api/lift"
        case .CreateComment:
            return "/api/comment"
        case .CreateUser:
            return "/api/user"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: SERVER_URL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let accessToken = defaults.stringForKey("accessToken") {
            mutableURLRequest.setValue("JWT \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        case .Login(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(
                mutableURLRequest,
                parameters: parameters
                ).0
        case .GetLift:
            return mutableURLRequest
        case .GetLifts(let page):
            let orderBy = [
                "order_by": [[
                    "field": "created_at",
                    "direction": "desc"
                ]],
                "page": page
            ]
            return Alamofire.ParameterEncoding.URL.encode(
                mutableURLRequest,
                parameters: [
                    "q": JSON(orderBy).rawString(NSUTF8StringEncoding)!,
                    "page": page
                ]
            ).0
        case .CreateVideo():
            return Alamofire.ParameterEncoding.JSON.encode(
                mutableURLRequest,
                parameters: ["file_extension": "MOV"]
            ).0
        case .CreateLift(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(
                mutableURLRequest,
                parameters: parameters
            ).0
        case .CreateComment(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(
                mutableURLRequest,
                parameters: parameters
            ).0
        case .CreateUser(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(
                mutableURLRequest,
                parameters: parameters
            ).0
        }
    }

}

