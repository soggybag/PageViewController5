//
//  LastPageViewController.swift
//  PageViewController4
//
//  Created by mitchell hudson on 12/14/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import UIKit

protocol LastPageViewControllerDelegate {
    func lastPageSaidDone()
}

class LastPageViewController: UIViewController {

    var delegate: LastPageViewControllerDelegate?
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        if let delegate = delegate {
            delegate.lastPageSaidDone()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
