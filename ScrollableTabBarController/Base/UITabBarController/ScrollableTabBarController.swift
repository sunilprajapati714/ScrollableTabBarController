//
//  MyTabBarController.swift
//  ScrollableTabBarController
//
//  Created by sunil.prajapati on 16/06/17.
//  Copyright © 2017 sunil.prajapati. All rights reserved.
//

import UIKit

@IBDesignable
class ScrollableTabBarController: UITabBarController{
    
    //MARK:- IBOutlet Declaration
    @IBOutlet var IBtapView: UIView!
    @IBOutlet weak var IBtabScrollView: UIScrollView!
    
    @IBInspectable var onTop : Bool = false
    @IBInspectable var noOfTabs : UInt = 1
//    @IBInspectable var tabNames: String? = "Tab Item 1"
    @IBInspectable var tabSize : CGSize = CGSize(width: UIScreen.main.bounds.width, height: 30)
    @IBInspectable var tabColor: UIColor? = UIColor.lightGray
    @IBInspectable var selectionColor: UIColor? = UIColor.cyan
    open var tabNames: String? = "Tab Item 1"
    open var tabImages: String? = "Tab Item Images"
    open var arrTabBarModel = [TabBarModel]()
    
    override var selectedIndex: Int{
        get{
            return super.selectedIndex
        }
        set{
            self.animateToTab(toIndex: newValue)
            super.selectedIndex = newValue
        }
    }
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureCustomViewWithSettings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- IBAction Methods
    @IBAction func didTapTabBarButton(_ sender: UIButton) {
        
        guard selectedIndex != sender.tag else {
            return
        }        
        self.unSelectAllTabs()
        sender.backgroundColor = selectionColor //Select Tab's Set BGColor
        self.selectedIndex = sender.tag
    }
    
    //MARK:- User Define Methods
    func unSelectAllTabs(){
        for btn in IBtabScrollView.subviews{btn.backgroundColor = tabColor}
    }
    
    func configureCustomViewWithSettings(){
        
        self.tabBar.isHidden = true
        //Load Custom Tab UIView 
        Bundle.main.loadNibNamed("CustomTabUIView", owner: self, options: nil)
        
        //Set Postion Of TabBar Controller
        if onTop == true{
            IBtapView.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: tabSize.height)
        }else{
            IBtapView.frame = CGRect(x: 0, y: self.view.frame.height-tabSize.height, width: self.view.frame.width, height: tabSize.height)
        }
        
        //Add Custom View into TabBarController
        self.view.addSubview(IBtapView)
        
        if (tabSize.width * CGFloat(noOfTabs)) <= self.view.frame.width{
            tabSize = CGSize(width: (self.view.frame.width / CGFloat(noOfTabs) - (2 + (2/CGFloat(noOfTabs)))), height: tabSize.height)
        }
        
        let arrTabNames = tabNames?.components(separatedBy: ",")
        let arrTabImages = tabImages?.components(separatedBy: ",")
        
        //Add No Of Tabs into ScrollView
        for index in 0..<Int(noOfTabs){
            
            let tabPoint = CGPoint(x: (CGFloat(index) * tabSize.width)+(CGFloat(index+1) * 2), y: 2)
            
            var tabBtn = UIButton()
            
            if arrTabBarModel.count > index{
                
                tabBtn = UIButton(frame: CGRect(origin: tabPoint, size: CGSize(width: tabSize.width, height: ((tabSize.height-5) * 4)/5)))
                tabBtn.setImage(UIImage(named: arrTabBarModel[index].tabImage), for: .normal)
                tabBtn.imageView?.contentMode = .scaleToFill
                
                let tabLbl = UILabel(frame: CGRect(x: tabPoint.x, y: tabBtn.frame.height+2, width: tabSize.width, height: (tabSize.height-5)/5))
                tabLbl.backgroundColor = UIColor.clear
                tabLbl.textColor = UIColor.white
                tabLbl.text = arrTabBarModel[index].tabName
                self.IBtabScrollView.addSubview(tabLbl)
                
            }else{
                
                tabBtn = UIButton(frame: CGRect(origin: tabPoint, size: CGSize(width: tabSize.width, height: tabSize.height-4)))
                tabBtn.setTitle("Tab Item \(index+1)", for: .normal)
            }
            
            tabBtn.tag = index
            tabBtn.addTarget(self, action: #selector(self.didTapTabBarButton(_:)), for: .touchUpInside)
            tabBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 15.0)
            tabBtn.titleLabel?.adjustsFontSizeToFitWidth = true
            tabBtn.backgroundColor = index == 0 ? selectionColor : tabColor
            self.IBtabScrollView.addSubview(tabBtn)
        }
        
        //Set Content Size of ScrollView
        IBtabScrollView.contentSize = CGSize(width: (tabSize.width * CGFloat(noOfTabs))+(2 * CGFloat(noOfTabs+1)), height: tabSize.height)
        self.IBtabScrollView.backgroundColor = selectionColor
    }
    
    func addImagesAndTitleOnTabs(){
        
    }
    
    func addImagesOnlyOnTabs(){
        
    }
    
    func addTitleOnlyOnTabs(){
        
    }
    
    //Add Custom Animation When Nagviagte ONe View Controller To Another View Controller
    func animateToTab(toIndex: Int) {
        guard let tabViewControllers = viewControllers, tabViewControllers.count > toIndex, let fromViewController = selectedViewController, let fromIndex = tabViewControllers.index(of: fromViewController), fromIndex != toIndex else {return}
        
        view.isUserInteractionEnabled = false
        
        let toViewController = tabViewControllers[toIndex]
        let push = toIndex > fromIndex
        let bounds = UIScreen.main.bounds
        
        let offScreenCenter = CGPoint(x: fromViewController.view.center.x + bounds.width, y: toViewController.view.center.y)
        let partiallyOffCenter = CGPoint(x: fromViewController.view.center.x - bounds.width*0.25, y: fromViewController.view.center.y)
        
        if push{
            fromViewController.view.superview?.addSubview(toViewController.view)
            toViewController.view.center = offScreenCenter
        }else{
            fromViewController.view.superview?.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            toViewController.view.center = partiallyOffCenter
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            toViewController.view.center   = fromViewController.view.center
            fromViewController.view.center = push ? partiallyOffCenter : offScreenCenter
        }, completion: { finished in
            fromViewController.view.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        })
    }
}
