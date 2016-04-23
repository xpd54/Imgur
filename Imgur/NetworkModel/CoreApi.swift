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
private let baseUrl = "https://api.imgur.com/3/gallery/"
// MARK: TODO Chage Clint Id if it expire in a month
private let clintId = "00ec4f971c9b3e2"
class CoreApi: NSObject {

    class func makeApiCallForUrlEndPoint(urlEndPoint: String, method: NetworkMethod, apiData: NSDictionary?, completion:(response: AnyObject?) -> Void)  {
        CoreApi.makeApiCallFor(baseUrl, urlEndPoint: urlEndPoint, method: method, apiData: apiData, completion: completion)
    }

    class func makeApiCallFor(baseUrl: String, urlEndPoint: String, method: NetworkMethod, apiData: NSDictionary?, completion:(response: AnyObject?) -> Void)  {
        let fullUrl = baseUrl + urlEndPoint
        let formatedApiData = apiData as! [String : AnyObject]?
        if method == NetworkMethod.GET {
            CoreApi.apiRequest(.GET, url: fullUrl, apiData: formatedApiData, completion: completion)
        } else if method == NetworkMethod.POST {
            CoreApi.apiRequest(.POST, url: fullUrl, apiData: formatedApiData, completion: completion)
        }
    }

    private class func apiRequest(method: Alamofire.Method, url: String, apiData: [String : AnyObject]? = nil, completion:(response: AnyObject?) ->Void) {
        let authoKey = "Authorization"
        let authoValue = "Client-ID \(clintId)"
        let apiHeader = [authoKey : authoValue]

        Alamofire.request(method, url, headers: apiHeader) .responseJSON { response in
            let responseData = response.data

            do {
                let decodedJson = try NSJSONSerialization.JSONObjectWithData(responseData!, options: NSJSONReadingOptions.AllowFragments)
                completion(response: decodedJson)
            } catch {
                print("Error")
            }
        }
    }
}
