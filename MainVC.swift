//
//  MainVC.swift
//  MyMeds2
//
//  Created by Don Gordon on 3/11/17.
//  Copyright © 2017 DGsolutions. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Outlets
    @IBOutlet weak var sortSelectorSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    weak var moc: NSManagedObjectContext! {
        didSet {
            return med = Med(context: moc)
        }
    }
    
    lazy var meds = [Med]()
    var med: Med? = nil
    var isCurrentlyTaken: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    // MARK: Table View Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedsListCell", for: indexPath) as! MyMedViewCell
        
        let currentMed = meds[indexPath.row]
        cell.configureCell(med: currentMed)
        
        return cell
    }
    
    // MARK: Private function - LoadData
    private func loadData() {
        // We do not want to do "business" work here, rather in the Model classes
        meds = med!.getMedsByCurrent(isCurrentlyTaking: isCurrentlyTaken, moc: moc)
        tableView.reloadData()
    }
    
    @IBAction func sortSegmentPressed(_ sender: UISegmentedControl) {
        let selectedValue = sender.titleForSegment(at: sender.selectedSegmentIndex)
        isCurrentlyTaken = selectedValue == "Discontinued" ? false : true
        loadData()
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

