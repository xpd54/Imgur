//
//  ConfigViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 02/05/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {
    var windowPicker : UIPickerView!
    var windowPickerArray : NSArray!
    var sectionPicker : UIPickerView!
    var sectionPickerArray : NSArray!
    var viralSwitch : UISwitch!
    private let barTitle = "Config"
    private let sectionPlaceHolder = "Choose Section"
    private let sTitleText = "Select Section"
    private let wTitleText = "Select Window"
    private let switchTitle = "I Like It, Let's Go Viral 😜"
    private let saveButtonTitle = "Save"
    private let titleTextSize : CGFloat = 18.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override func loadView() {
        super.loadView()
        self.navigationItem.title = barTitle
        self.view.backgroundColor = UIColor.lightGrayColor()
        let saveButton = UIBarButtonItem(title: saveButtonTitle,
                                         style: UIBarButtonItemStyle.Plain,
                                         target: self,
                                         action: #selector(seaveConfg))
        self.navigationItem.rightBarButtonItem = saveButton

        let sectionTitle = UILabel()
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        sectionTitle.font = UIFont.boldSystemFontOfSize(titleTextSize)
        sectionTitle.text = sTitleText
        sectionTitle.textAlignment = .Left

        sectionPicker = UIPickerView()
        sectionPicker.translatesAutoresizingMaskIntoConstraints = false
        sectionPicker.dataSource = self
        sectionPicker.delegate = self
        sectionPicker.showsSelectionIndicator = true
        sectionPicker.tag = 1
        
        let windowTitle = UILabel()
        windowTitle.translatesAutoresizingMaskIntoConstraints = false
        windowTitle.font = UIFont.boldSystemFontOfSize(titleTextSize)
        windowTitle.text = wTitleText
        windowTitle.textAlignment = .Left

        windowPicker = UIPickerView()
        windowPicker.translatesAutoresizingMaskIntoConstraints = false
        windowPicker.dataSource = self
        windowPicker.delegate = self
        windowPicker.showsSelectionIndicator = true
        windowPicker.tag = 2

        let switchLable = UILabel()
        switchLable.translatesAutoresizingMaskIntoConstraints = false
        switchLable.font = UIFont.boldSystemFontOfSize(titleTextSize)
        switchLable.text = switchTitle
        switchLable.textAlignment = .Left

        viralSwitch = UISwitch()
        viralSwitch.translatesAutoresizingMaskIntoConstraints = false
        viralSwitch.onTintColor = UIColor.greenColor()
        viralSwitch.tintColor = UIColor.whiteColor()
        viralSwitch.thumbTintColor = UIColor.whiteColor()

        self.view.addSubview(switchLable)
        self.view.addSubview(viralSwitch)
        self.view.addSubview(windowTitle)
        self.view.addSubview(sectionTitle)
        self.view.addSubview(sectionPicker)
        self.view.addSubview(windowPicker)
        let views = ["window" : windowPicker,
                     "section" : sectionPicker,
                     "windowTitle" : windowTitle,
                     "sectionTitle" : sectionTitle,
                     "viral" : viralSwitch,
                     "switchLable" : switchLable]
        let hcStringSection = "H:|-0-[section(sectionTitle)]-0-|"
        let hcStringWindow = "H:|-0-[window(windowTitle)]-0-|"
        let hcStringSwitch = "H:|-0-[switchLable]-0-[viral]-0-|"
        let vcStringSection = "V:|-10-[switchLable(sectionTitle)]-20-[sectionTitle(windowTitle)]-0-[section(window)]-0-[windowTitle]-0-[window]-|"
        
        let hcWindow = NSLayoutConstraint.constraintsWithVisualFormat(hcStringWindow,
                                                                      options: NSLayoutFormatOptions.AlignAllTop,
                                                                      metrics: nil,
                                                                      views: views)
        let hcSection = NSLayoutConstraint.constraintsWithVisualFormat(hcStringSection,
                                                                       options: NSLayoutFormatOptions.AlignAllTop,
                                                                       metrics: nil,
                                                                       views: views)
        let hcSwitch = NSLayoutConstraint.constraintsWithVisualFormat(hcStringSwitch,
                                                                      options: NSLayoutFormatOptions.AlignAllTop,
                                                                      metrics: nil,
                                                                      views: views)
        let vcSection = NSLayoutConstraint.constraintsWithVisualFormat(vcStringSection,
                                                                       options: NSLayoutFormatOptions.AlignAllLeft,
                                                                       metrics: nil,
                                                                       views: views)
        self.view.addConstraints(hcWindow)
        self.view.addConstraints(hcSection)
        self.view.addConstraints(hcSwitch)
        self.view.addConstraints(vcSection)
    }

    func seaveConfg() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ConfigViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Yes")
        print("\(pickerView.tag)")
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "got you"
    }
}