//
//  DataManager.swift
//  Imgur
//
//  Created by Ravi Prakash on 23/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

enum DataType : NSString {
    case Title = "title"
    case Description = "description"
    case UpVote = "ups"
    case DownVote = "downs"
    case Score = "score"
    case TypeOfData = "type"
    case ImageLink = "link"
    case Height  = "height"
    case Width = "width"
}

class DataManager: NSObject {
    //Pass NSDictionary from CoreApi completion block
    class func getListOfData(jsonList: NSDictionary) -> NSArray {
        let dataKey = "data"
        let finalDataList = NSMutableArray()
        let dataArray = jsonList.objectForKey(dataKey) as! NSArray
        for obj in dataArray {
            let data = obj as! NSDictionary
            let dataDict = NSMutableDictionary()
            if data.objectForKey(DataType.TypeOfData.rawValue) != nil {
                if let value = data.objectForKey(DataType.Title.rawValue) {
                    dataDict.setObject(value, forKey: DataType.Title.rawValue)
                }

                if let value = data.objectForKey(DataType.Description.rawValue) {
                    dataDict.setObject(value, forKey: DataType.Description.rawValue)
                }

                if let value = data.objectForKey(DataType.UpVote.rawValue) {
                    dataDict.setObject(value, forKey: DataType.UpVote.rawValue)
                }

                if let value = data.objectForKey(DataType.DownVote.rawValue) {
                    dataDict.setObject(value, forKey: DataType.DownVote.rawValue)
                }

                if let value = data.objectForKey(DataType.Score.rawValue) {
                    dataDict.setObject(value, forKey: DataType.Score.rawValue)
                }

                if let value = data.objectForKey(DataType.ImageLink.rawValue) {
                    dataDict.setObject(value, forKey: DataType.ImageLink.rawValue)
                }
                
                if let value = data.objectForKey(DataType.Height.rawValue) {
                    dataDict.setObject(value, forKey: DataType.Height.rawValue)
                }

                if let value = data.objectForKey(DataType.Width.rawValue) {
                    dataDict.setObject(value, forKey: DataType.Width.rawValue)
                }
                finalDataList.addObject(dataDict)
            }
        }
        return finalDataList
    }
}
