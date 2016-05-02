//
//  UrlGenerator.swift
//  Imgur
//
//  Created by Ravi Prakash on 02/05/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class UrlGenerator: NSObject {
    class func getUrlEndPoint(pageNumber : Int) -> String {
        if let configDict = PersistentDataStore.objectForKey(configDictKey) {
            var endPointString = String()
            let sectionValue = configDict[sectionKey] as! NSString
            let windowValue = configDict[windowKey] as! NSString
            let viral = configDict[showViral] as! Bool
            if sectionValue.isEqualToString("top") {
                endPointString.appendContentsOf("top/\(windowValue)/\(pageNumber)")
            } else if sectionValue.isEqualToString("user") {
                endPointString.appendContentsOf("\(sectionValue)/\(pageNumber)?showViral=\(viral)")
            } else {
                endPointString.appendContentsOf("\(sectionValue)/\(pageNumber)")
            }
            return endPointString
        }
        return ""
    }
}
