//
//  CoreApi.swift
//  Imgur
//
//  Created by Ravi Prakash on 21/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit
import Alamofire

internal enum NetworkMethod: String {
    case GET,POST
}

class CoreApi: NSObject {
    class func makeApiCallForUrlEndPoint(urlEndPoint: String, method: NetworkMethod, apiData: [String : AnyObject]? = nil, completion:(response: AnyObject?) -> Void)  {
        CoreApi.makeApiCallFor(BASE_URL, urlEndPoint: urlEndPoint, method: method, apiData: apiData, completion: completion)
    }

    class func makeApiCallFor(baseUrl: String, urlEndPoint: String, method: NetworkMethod, apiData: [String: AnyObject]? = nil, completion:(response: AnyObject?) -> Void)  {
        let fullUrl = baseUrl + urlEndPoint
        if method == NetworkMethod.GET {
            CoreApi.apiRequest(.GET, url: fullUrl, apiData: apiData, completion: completion)
        } else if method == NetworkMethod.POST {
            CoreApi.apiRequest(.POST, url: fullUrl, apiData: apiData, completion: completion)
        }
    }

    private class func apiRequest(method: Alamofire.Method, url: String, apiData: [String : AnyObject]? = nil, completion:(response: AnyObject?) ->Void) {
        Alamofire.request(method, url, parameters: apiData).responseData { response in
            let responseData = response.data
            do {
                let decodedJson:AnyObject? = try NSJSONSerialization.JSONObjectWithData(responseData!, options: NSJSONReadingOptions.AllowFragments)
                completion(response: decodedJson)
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
        }
    }
}
