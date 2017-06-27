//
//  TabBarModel.swift
//  ScrollableTabBarController
//
//  Created by sunil.prajapati on 22/06/17.
//  Copyright © 2017 sunil.prajapati. All rights reserved.
//

import Foundation

class CustomTabBar : NSObject{
    
    var name : String?
    var selectImage : String?
    var deSelectImage : String?
    var badgeNumber : Int?
    
    init(name: String?, selectImage: String?, deSelectImage: String?, badgeNumber : Int? = nil) {
        self.name = name
        self.selectImage = selectImage
        self.deSelectImage = deSelectImage
        self.badgeNumber = badgeNumber
    }
}
