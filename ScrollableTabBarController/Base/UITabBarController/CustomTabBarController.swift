//
//  CustomTabBarController.swift
//  ScrollableTabBarController
//
//  Created by sunil.prajapati on 22/06/17.
//  Copyright © 2017 sunil.prajapati. All rights reserved.
//

import UIKit

class CustomTabBarController: ScrollableTabBarController {

    let tName = "VC1,VC2,VC3,VC4,VC5"
    let tImages = "VC1,VC2,VC3,VC4,VC5"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabNames = tName
        self.tabImages = tImages
        
        let tab1 = TabBarModel(tabName: "VC1", tabImage: "VC1")
        let tab2 = TabBarModel(tabName: "VC2", tabImage: "VC2")
        let tab3 = TabBarModel(tabName: "VC3", tabImage: "VC3")
        let tab4 = TabBarModel(tabName: "VC4", tabImage: "VC4")
        let tab5 = TabBarModel(tabName: "VC5", tabImage: "VC5")
        self.arrTabBarModel = [tab1,tab2,tab3,tab4,tab5]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
