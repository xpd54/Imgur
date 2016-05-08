//
//  UrlGenerator.swift
//  Imgur
//
//  Created by Ravi Prakash on 02/05/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit
private let DEFAULTS_SECTION = "hot"
private let DEFAULTS_WINDOW = "day"
private let DEFAULTS_VIRAL = false
class UrlGenerator: NSObject {
    class func getUrlEndPoint(pageNumber : Int) -> String {
        var endPointString = String()
        var sectionValue = String()
        var windowValue = String()
        var viral = Bool()
        if let configDict = PersistentDataStore.objectForKey(configDictKey) {
            sectionValue = configDict[sectionKey] as! String
            windowValue = configDict[windowKey] as! String
            viral = configDict[showViral] as! Bool
        } else {
            sectionValue = DEFAULTS_SECTION
            windowValue = DEFAULTS_WINDOW
            viral = DEFAULTS_VIRAL
        }
        if sectionValue == "top" {
            endPointString.appendContentsOf("top/\(windowValue)/\(pageNumber)")
        } else if sectionValue == "user" {
            endPointString.appendContentsOf("\(sectionValue)/\(pageNumber)?showViral=\(viral)")
        } else {
            endPointString.appendContentsOf("\(sectionValue)/\(pageNumber)")
        }
        return endPointString
    }
}
