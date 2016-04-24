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
private let writeQueue  = dispatch_queue_create("com.xpd54.imgur.write", nil)
private let readQueue = dispatch_queue_create("com.xpdte.imgur.read", nil)
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

    class func saveImage(image:UIImage, imageName:String) {
        dispatch_async(writeQueue) {
            let path = DataManager.getPathInDocumentDirectory(imageName)
            let data = UIImagePNGRepresentation(image)
            do {
                try data?.writeToFile(path, options: NSDataWritingOptions.AtomicWrite)
            } catch {
                print("Devil is here")
            }
        }

    }

    class func getImage(imageName:String, completion:(image: UIImage)->Void) {
        dispatch_async(readQueue) {
            let path = DataManager.getPathInDocumentDirectory(imageName)
            let image = UIImage.init(contentsOfFile: path)
            dispatch_async(dispatch_get_main_queue(), {
                completion(image: image!)
            })
        }
    }

    class func isImageAvailable(imageName:String) -> Bool {
        let path = DataManager.getPathInDocumentDirectory(imageName)
        return NSFileManager.defaultManager().fileExistsAtPath(path)
    }

    private class func getPathInDocumentDirectory(imageName:String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentDirectory = paths[0]
        let path = documentDirectory.stringByAppendingString("/\(imageName)")
        return path
    }
}
