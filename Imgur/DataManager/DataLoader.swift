//
//  DataLoader.swift
//  Imgur
//
//  Created by Ravi Prakash on 28/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit
protocol ImgurData {
    func imgurDataGotLoaded()
}
class DataLoader: NSObject {
    var dataDeligate: ImgurData!
    func loadImgurData(pageNo:Int) {
        let queue = dispatch_queue_create("com.xpd54.imgurLoadData", nil)
        dispatch_async(queue) {
            let endPoint = "hot/viral/\(pageNo).json"
            CoreApi.makeApiCallForUrlEndPoint(endPoint, method: NetworkMethod.GET, apiData: nil) { (response) in
                let imgurDataList = DataManager.getListOfData(response)
                DataInMemoryCache.sharedInstance.imgurData.addObjectsFromArray(imgurDataList as [AnyObject])
                dispatch_async(dispatch_get_main_queue(), {
                    self.dataDeligate.imgurDataGotLoaded()
                })
            }
        }
    }
}
