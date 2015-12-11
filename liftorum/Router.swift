import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "http://f7fe8526.ngrok.io"
    
    case Login([String: AnyObject])
    case GetLifts(page: Int)
    case CreateVideo()
    case CreateLift([String: AnyObject])
    
    var method: Alamofire.Method {
        switch self {
        case .Login:
            return .POST
        case .GetLifts:
            return .GET
        case .CreateVideo:
            return .POST
        case .CreateLift:
            return .POST
        }
    }

    var path: String {
        switch self {
        case .Login:
            return "/auth"
        case .GetLifts:
            return "/api/lift"
        case .CreateVideo:
            return "/api/video"
        case .CreateLift:
            return "/api/lift"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        switch self {
        case .Login(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(
                mutableURLRequest,
                parameters: parameters
                ).0
        case .GetLifts(let page):
            return Alamofire.ParameterEncoding.URL.encode(
                mutableURLRequest,
                parameters: ["page": page]
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

        }
    }

}

