import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "http://cd19dc2a.ngrok.io/api"
    
    case ReadLifts()
    case CreateVideo(fileExtension: String)
    
    var method: Alamofire.Method {
        switch self {
        case .ReadLifts:
            return .GET
        case CreateVideo:
            return .POST
        }
        
        

    }

    var path: String {
        switch self {
        case .ReadLifts:
            return "/lift"
        case .CreateVideo:
            return "/video"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        switch self {
        case .CreateVideo(let fileExtension):
            return Alamofire.ParameterEncoding.JSON.encode(
                mutableURLRequest,
                parameters: ["file_extension": fileExtension]
            ).0
        default:
            return mutableURLRequest
        }
    }
}