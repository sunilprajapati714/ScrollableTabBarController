//
//  TabBarModel.swift
//  ScrollableTabBarController
//
//  Created by sunil.prajapati on 22/06/17.
//  Copyright © 2017 sunil.prajapati. All rights reserved.
//

import Foundation

class CustomTabBar : NSObject{
    
    let name : String?
    let selectImage : String?
    let deSelectImage : String?
    
    init(name: String?, selectImage: String?, deSelectImage: String?) {
        self.name = name
        self.selectImage = selectImage
        self.deSelectImage = deSelectImage
    }
}
