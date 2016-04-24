//
//  DataInMemoryCache.swift
//  Imgur
//
//  Created by Ravi Prakash on 23/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class DataInMemoryCache: NSObject {
    static let sharedInstance = DataInMemoryCache()
    let imgurData = NSMutableArray()
}
