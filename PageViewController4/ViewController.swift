//
//  ViewController.swift
//  PageViewController4
//
//  Created by mitchell hudson on 9/6/15.
//  Copyright (c) 2015 mitchell hudson. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
        UIPageViewControllerDelegate,
        UIPageViewControllerDataSource,
        LastPageViewControllerDelegate {
    
    // An array with the names of the ViewControllers that will displayed in the 
    // page view controller. These are the Storyboard id names. ! Be sure to 
    // check the box next to restoration id: Use Storyboard ID.
    var pageArray = ["PageOne", "PageTwo", "PageThree", "PageFour"]
    // Index of the view controller to display.
    var index = 0
    // The Page View controller
    var pageViewController: UIPageViewController!

    
    func lastPageSaidDone() {
        print("Last Page Said Done")
        if let appVC = storyboard?.instantiateViewControllerWithIdentifier("YourAppViewControler") {
            let currentVC = pageViewController
            
            appVC.view.frame = currentVC.view.frame
            appVC.willMoveToParentViewController(nil)
            addChildViewController(appVC)
            
            transitionFromViewController(currentVC, toViewController: appVC, duration: 1.0, options: .TransitionCrossDissolve, animations: { () -> Void in
                //
                }, completion: { (completed: Bool) -> Void in
                    currentVC.removeFromParentViewController()
                    appVC.didMoveToParentViewController(self)
            })
            
        }
    }
    
    
    // MARK: - Utility Methods
    
    // This method returns a view controller with the ID at index in array.
    func getViewControllerAtIndex(index: Int) -> UIViewController? {
        // Create a view controller from Storyboard
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier(pageArray[index])
        
        if let lastPageVC = vc as? LastPageViewController {
            lastPageVC.delegate = self
        }
        
        // Return the view controller
        return vc
    }
    
    
    
    // MARK: - Page View Controller 
    
    // PageViewController delegate methods 
    
    // Returns the View Controller before the current view controller
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        // Get the index of the view controller before the current view controller
        // Start by setting currentIndex to nil
        var currentIndex: Int? = nil
        // Get the Restoration ID of the current view controller
        if let id = viewController.restorationIdentifier {
            // Find that name in the array
            currentIndex = pageArray.indexOf(id)!
        }
        // If currentIndex has a value get the view controller at that index -1.
        if currentIndex! > 0 {
            // Subtract 1, we want the view controller before the current Index
            return getViewControllerAtIndex(currentIndex! - 1)
        }
        // Otherwise return nil
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        // Get the view controller after the current view controller
        // Set index to nil
        var currentIndex: Int? = nil
        // Now find the id of the current view controller in the array
        if let id = viewController.restorationIdentifier {
            // Get the index of the current view controller id in array
            currentIndex = pageArray.indexOf(id)!
        }
        
        // Trya and get the view controller after this one.
        if currentIndex! < pageArray.count - 1 {
            // Add 1 to current index and get that view controller.
            return getViewControllerAtIndex(currentIndex! + 1)
        }
        
        // Otherwise return nil
        return nil
    }
    
    
    // Some other PageViewController delegate methods
     /*
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("Page View Did Finish:\(finished)")
        print(previousViewControllers)
        
    }
   
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageArray.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    */
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Make a Page View Controller 
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        // Set this class as the delegate
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        // Add the PageView Controller as a child view controller
        self.addChildViewController(self.pageViewController)
        
        // Need to add it's view also
        self.view.addSubview(self.pageViewController.view)
        
        // Make an array of view controllers with the first view controller
        let viewControllers = [getViewControllerAtIndex(0)!]
        // Set the array of view controllers to start the page view controller
        self.pageViewController.setViewControllers(viewControllers,
            direction: UIPageViewControllerNavigationDirection.Forward,
            animated: false,
            completion: nil)
        self.pageViewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

