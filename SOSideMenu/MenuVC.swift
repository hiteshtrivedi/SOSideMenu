//
//  MenuVC.swift
//  SOSideMenu
//
//  Created by Hitesh on 11/16/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var tblMenu: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actionMenu(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.openSegue("openMenu", sender: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "Index \(indexPath.row)"
        return cell
    }


}


protocol MenuDelegate {
    func openSegue(segueName: String, sender: AnyObject?)
    func openMenu()
}

extension MenuVC : MenuDelegate {
    func openSegue(segueName: String, sender: AnyObject?) {
        dismissViewControllerAnimated(true){
            //self.performSegueWithIdentifier(segueName, sender: sender)
        }
    }
    func openMenu(){
        performSegueWithIdentifier("openMenu", sender: nil)
    }
}

