//
//  ViewController1.swift
//  ScrollableTabBarController
//
//  Created by sunil.prajapati on 16/06/17.
//  Copyright © 2017 sunil.prajapati. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    
    //MARK:- IBOutlet Declaration
    var msg : String?
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        //Set TabBar's BadgeNumber
        if let tabBarController = self.tabBarController as? CustomTabBarController{
            tabBarController.tab1?.badgeNumber = 100
            tabBarController.reloadTabBar()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- IBAction Methods
    @IBAction func btnAnotherViewController(_ sender: Any) {
        if let anotherVC = self.storyboard?.instantiateViewController(withIdentifier: "AnotherViewController") as? AnotherViewController {
            self.navigationController?.pushViewController(anotherVC, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAnother"{
            print("OK")
        }
    }
    
    @IBAction func backToVC1(sender : UIStoryboardSegue){
        print("View Controller 1")
        if let msg = msg{
            print(msg)
        }
    }
}
