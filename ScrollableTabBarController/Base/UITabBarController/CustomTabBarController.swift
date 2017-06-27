//
//  CustomTabBarController.swift
//  ScrollableTabBarController
//
//  Created by sunil.prajapati on 22/06/17.
//  Copyright © 2017 sunil.prajapati. All rights reserved.
//

import UIKit

class CustomTabBarController: ScrollableTabBarController {
    
    //MARK:- IBOutlet Declaration
    var tab1 : CustomTabBar?
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add TabBarModel tab with Name and Image property
        tab1 = CustomTabBar(name: "Tab 1", selectImage: "setting_select", deSelectImage: "setting_unselect")
        let tab2 = CustomTabBar(name: "Tab 2", selectImage: "star_select", deSelectImage: "star_unselect")
        let tab3 = CustomTabBar(name: nil, selectImage: "heart_select", deSelectImage: "heart_unselect", badgeNumber: 3)
        let tab4 = CustomTabBar(name: nil, selectImage: "user_select", deSelectImage: "user_unselect")
        let tab5 = CustomTabBar(name: "Tab 5", selectImage: nil, deSelectImage: nil, badgeNumber: 5)
        let tab6 = CustomTabBar(name: "Tab 6", selectImage: nil, deSelectImage: nil)
        
        self.tabBars = [tab1!,tab2,tab3,tab4,tab5,tab6]
    }
    
    func btnclick(){
        tab1?.badgeNumber = 1
        self.reloadTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        btnclick()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
