//
//  DescriptionView.swift
//  Imgur
//
//  Created by Ravi Prakash on 26/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class DescriptionView: UIView {
    var imageDescription: String!
    var descriptionView:UITextView!
    init(frame: CGRect, imageInformation:NSDictionary) {
        super.init(frame: frame)
        self.setUpView(imageInformation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(imageInformation:NSDictionary) {
        descriptionView = UITextView()
        if let dis = imageInformation.objectForKey(DataType.Description.rawValue) {
            self.imageDescription = dis as! String
        }
        descriptionView.text = imageDescription
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.editable = false
        descriptionView.selectable = false
        descriptionView.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(descriptionView)
        let mainViews = ["description" : descriptionView]
        let hcString = "H:|-0-[description]-0-|"
        let vcString = "V:|-0-[description]-0-|"
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hcString, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: mainViews)
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vcString, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: mainViews)
        self.addConstraints(horizontalConstraint)
        self.addConstraints(verticalConstraint)
    }
}
