//
//  AnotherViewController.swift
//  ScrollableTabBarController
//
//  Created by sunil.prajapati on 16/06/17.
//  Copyright © 2017 sunil.prajapati. All rights reserved.
//

import UIKit

class AnotherViewController: UIViewController {

    //MARK:- IBOutlet Declaration
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc1 = segue.destination as? ViewController1{
            vc1.msg = "Unwing Segue."
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
