//
//  Home+Extension.swift
//  MyMeds2
//
//  Created by Don Gordon on 3/14/17.
//  Copyright © 2017 DGsolutions. All rights reserved.
//

import Foundation
import CoreData

extension Med {
    
    // Return all 'isCurrentlyTaking' Meds
    func getMedsByCurrent(isCurrentlyTaking: Bool, moc: NSManagedObjectContext) -> [Med] {
        let request: NSFetchRequest<Med> = Med.fetchRequest()
        request.predicate = NSPredicate(format: "isCurrentlyTaking = %@", isCurrentlyTaking as CVarArg)
        
        do {
            let meds = try moc.fetch(request)
            return meds
        }
        catch {
            fatalError("Error in getting list of meds.")
        }
    }

    
}
