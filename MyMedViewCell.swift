//
//  MyMedViewCell.swift
//  MyMeds2
//
//  Created by Don Gordon on 3/13/17.
//  Copyright © 2017 DGsolutions. All rights reserved.
//

import UIKit

class MyMedViewCell: UITableViewCell {

    @IBOutlet weak var genericNameLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var dosageLabel: UILabel!
    @IBOutlet weak var pillsBottleLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var picImage: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(med: Med) {
        genericNameLabel.text = med.genericName
        brandNameLabel.text = med.brandName
        dosageLabel.text = med.pillDosage
 //       pillsBottleLabel.text = String(med.pillsPerBottle)
        scheduleLabel.text = String(med.pillsPerBottle)
        
        let image = UIImage(data: med.image as! Data)
        picImage.image = image
        picImage.layer.borderWidth = 1
        picImage.layer.cornerRadius = 4
    }

}
