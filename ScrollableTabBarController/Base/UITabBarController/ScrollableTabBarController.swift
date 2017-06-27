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
    @IBInspectable var tabSize : CGSize = CGSize(width: UIScreen.main.bounds.width, height: 30)
    @IBInspectable var tabColor: UIColor? = UIColor.lightGray
    @IBInspectable var selectionColor: UIColor? = UIColor.cyan
    @IBInspectable var borderColor: UIColor? = UIColor.orange
    open var tabBars = [CustomTabBar]()
    
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
        self.unSelectAllTabs(index: sender.tag)
        self.selectedIndex = sender.tag
    }
    
    //MARK:- User Define Methods
    func unSelectAllTabs(index : Int){

        for view in IBtabScrollView.subviews{
            
            view.clipsToBounds == true ? (view.backgroundColor = selectionColor) : (view.backgroundColor = tabColor)
            if view.tag == index{
                view.clipsToBounds == true ? (view.backgroundColor = tabColor) : (view.backgroundColor = selectionColor)
            }
            
            //Change State Of Button ofr select and unselect
            if let btn = view as? UIButton{
                btn.tag == index ? (btn.isSelected = true) : (btn.isSelected = false)
            }
        }
    }
    
    func configureCustomViewWithSettings(){
        
        self.tabBar.isHidden = true
        
        //Load Custom Tab UIView 
        Bundle.main.loadNibNamed("CustomTabUIView", owner: self, options: nil)
        guard noOfTabs > 0 else{
            self.IBtapView.isHidden = true
            return
        }
        
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
        
        //Add No Of Tabs into ScrollView with Images and Badge Numbers
        for index in 0..<Int(noOfTabs){
            
            let tabPoint = CGPoint(x: (CGFloat(index) * tabSize.width)+(CGFloat(index+1) * 2), y: 2)
            
            var tabBtn = UIButton()
            var lblBadge : UILabel?
            tabBtn = UIButton(frame: CGRect(origin: tabPoint, size: CGSize(width: tabSize.width, height: tabSize.height-4)))
            
            if tabBars.count > index{
                
                if let tabName = tabBars[index].name, let tabImage = tabBars[index].selectImage, let tabDeImage = tabBars[index].deSelectImage{
                    
                    //Add Button
                    tabBtn = UIButton(frame: CGRect(origin: tabPoint, size: CGSize(width: tabSize.width, height: tabSize.height-19)))
                    tabBtn.setBackgroundImage(UIImage(named: tabDeImage), for: .normal)
                    tabBtn.setBackgroundImage(UIImage(named: tabImage), for: .selected)
                    tabBtn.imageView?.contentMode = .scaleToFill
                    
                    //Add Label
                    let tabLbl = UILabel(frame: CGRect(x: tabPoint.x, y: tabBtn.frame.height+2, width: tabSize.width, height: 15))
                    tabLbl.backgroundColor = index == 0 ? selectionColor : tabColor
                    tabLbl.textColor = UIColor.white
                    tabLbl.textAlignment = .center
                    tabLbl.font = UIFont(name: "Helvetica Neue", size: 12.0)
                    tabLbl.text = tabName
                    tabLbl.tag = index
                    self.IBtabScrollView.addSubview(tabLbl)
                    
                }else if let tabName = tabBars[index].name{
                    tabBtn.setTitle(tabName, for: .normal)
                    
                }else if let tabImage = tabBars[index].selectImage, let tabDeImage = tabBars[index].deSelectImage{
                    tabBtn.setBackgroundImage(UIImage(named: tabDeImage), for: .normal)
                    tabBtn.setBackgroundImage(UIImage(named: tabImage), for: .selected)
                    tabBtn.imageView?.contentMode = .scaleToFill
                    
                }else{
                    tabBtn.setTitle("Tab Item \(index+1)", for: .normal)
                }
                
                if let badgeNumber = tabBars[index].badgeNumber{
                    
                    var size : CGFloat = 12
                    var bNumber = String(badgeNumber)
                    if badgeNumber > 99{
                        bNumber = "99+"
                        size = 8.5
                    }
                    
                    let x = ((CGFloat(index+1) * tabSize.width) + CGFloat(index * 2)-13)
                    lblBadge = UILabel(frame: CGRect(x: Int(x), y: 2, width: 15, height: 15))
                    lblBadge?.backgroundColor = index == 0 ? tabColor : selectionColor
                    lblBadge?.textColor = UIColor.white
                    lblBadge?.textAlignment = .center
                    lblBadge?.font = UIFont(name: "Helvetica Neue", size: size)
                    lblBadge?.text = bNumber
                    lblBadge?.tag = index
                    lblBadge?.layer.cornerRadius = 7.5
                    lblBadge?.clipsToBounds = true
                }
                
            }else{
                tabBtn.setTitle("Tab Item \(index+1)", for: .normal)
            }
            
            tabBtn.tag = index
            tabBtn.addTarget(self, action: #selector(self.didTapTabBarButton(_:)), for: .touchUpInside)
            tabBtn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 15.0)
            tabBtn.titleLabel?.adjustsFontSizeToFitWidth = true
            tabBtn.backgroundColor = index == 0 ? selectionColor : tabColor
            tabBtn.isSelected = (index == 0) ? true : false
            self.IBtabScrollView.addSubview(tabBtn)
            if let lblBadge = lblBadge{self.IBtabScrollView.addSubview(lblBadge)}
        }
        
        //Set Content Size of ScrollView
        IBtabScrollView.contentSize = CGSize(width: (tabSize.width * CGFloat(noOfTabs))+(2 * CGFloat(noOfTabs+1)), height: tabSize.height)
        self.IBtabScrollView.backgroundColor = borderColor
    }
    
    func reloadTabBar(){
        for subView in self.IBtapView.subviews{
            subView.removeFromSuperview()
        }
        self.configureCustomViewWithSettings()
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
