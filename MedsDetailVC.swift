//
//  MedsDetailVC.swift
//  MyMeds2
//
//  Created by Don Gordon on 3/14/17.
//  Copyright © 2017 DGsolutions. All rights reserved.
//

import UIKit

class MedsDetailVC: UIViewController {

    

    @IBOutlet weak var picImage: UIImageView!
    @IBOutlet weak var genericField: UITextField!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var dosageField: UITextField!
    @IBOutlet weak var pillsPerBottleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var currentlyTakenSwitch: UISwitch!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var scheduleTableView: UITableView!
    @IBOutlet weak var websiteTableView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var saveButtonPressed: UIBarButtonItem!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
