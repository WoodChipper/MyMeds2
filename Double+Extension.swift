//
//  Double+Extension.swift
//  MyMeds2
//
//  Created by Don Gordon on 3/14/17.
//  Copyright © 2017 DGsolutions. All rights reserved.
//

import Foundation

// set Double to Currency format
extension Double {
    var currencyFormatter: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
