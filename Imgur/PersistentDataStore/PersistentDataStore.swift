//
//  PersistentDataStore.swift
//  Imgur
//
//  Created by Ravi Prakash on 02/05/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit
let domainName = "com.xpd54.Imgur"
class PersistentDataStore: NSObject {
    private class func getPersistentDictionary() -> [String : AnyObject] {
        let persisteDict = [String : AnyObject]()
        if let dict = NSUserDefaults.standardUserDefaults().persistentDomainForName(domainName) {
            return dict
        }
        return persisteDict
    }

    private class func setPersistentDictionary(dict : NSDictionary) {
        NSUserDefaults.standardUserDefaults().setPersistentDomain(dict as! [String : AnyObject], forName: domainName)
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    class func objectForKey(key : String) -> AnyObject? {
        let persistentDict = PersistentDataStore.getPersistentDictionary()
        return persistentDict[key]
    }

    class func setObject(object : AnyObject, key : String) {
        var persistentDict = PersistentDataStore.getPersistentDictionary()
        persistentDict.updateValue(object, forKey: key)
        PersistentDataStore.setPersistentDictionary(persistentDict)
    }

    class func removeObject(key : String) {
        var persistentDict = PersistentDataStore.getPersistentDictionary()
        persistentDict.removeValueForKey(key)
        PersistentDataStore.setPersistentDictionary(persistentDict)
    }
}
