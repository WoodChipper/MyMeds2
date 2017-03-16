//
//  UploadSampleData.swift
//  MyMeds2
//
//  Created by Don Gordon on 3/12/17.
//  Copyright © 2017 DGsolutions. All rights reserved.
//

import UIKit
import CoreData

class UploadSampleData {
    
    var coreData = CoreDataStack()
    
    // CHECK IF APP ALREADY HAS DATA TO USE...
    func checkDataStore() {
        let request: NSFetchRequest<Med> = Med.fetchRequest()
        
        let moc = coreData.persistentContainer.viewContext
        do {
            let medCount = try moc.count(for: request)
            
            if medCount == 0 {
                uploadSampleData()
            }
        }
        catch {
            fatalError("Error in counting home record")
        }
    }
    
    
    // LOAD JSON SAMPLE DATA
    func uploadSampleData() {
        
        let moc = coreData.persistentContainer.viewContext
        

        
        let url = Bundle.main.url(forResource: "MedsData", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
            let jsonArray = jsonResult.value(forKey: "med") as! NSArray
            
            // var med: NSManagedObject
            for json in jsonArray {
                let medData = json as! [String: AnyObject]
                
                // Generic Name
                guard let generic = medData["generic"] else {
                    return
                }
                
                // Brand Name
                guard let brand = medData["brand"] else {
                    return
                }
                
                // notes
                guard let notes = medData["notes"] else {
                    return
                }
                
                // pillDosage
                guard let pillDosage = medData["pillDosage"] else {
                    return
                }
                
                // pillsPerBottle
                guard let pillsPerBottle = medData["pillsPerBottle"] else {
                    return
                }
                
                // pricePerBottle
                guard let pricePerBottle = medData["pricePerBottle"] else {
                    return
                }
                
                // isCurrentlyTaking
                guard let isCurrentlyTaking = medData["isCurrentlyTaking"] else {
                    return
                }
                
                // Picture Image
                var image: UIImage?
                if let currentImage = medData["image"] {   // returns a string
                    let imageName = currentImage as? String  // still a string
                    image = UIImage(named: imageName!)
                }
                
                // med object initialization (Med Entity)
                let med = Med(context: moc)
                
                // populate the Entity
                med.genericName = generic as? String
                med.brandName = brand as? String
                med.notes = notes as? String
                med.pillDosage = pillDosage as? String
                med.pillsPerBottle = pillsPerBottle.int32Value
                med.pricePerBottle = pricePerBottle as! Double
                med.isCurrentlyTaking = isCurrentlyTaking as! Bool
                med.image = NSData.init(data: UIImageJPEGRepresentation(image!, 1)!)
                
                
                // myDosage  [amount, when]
                if let myDosages = medData["myDosage"] {
                    let myDosageData = med.relMyDosage?.mutableCopy() as! NSMutableSet
                    
                    for  dosageDetail in myDosages as! NSArray {
                        let dosageData = dosageDetail as! [String: AnyObject]
                        
                        let dosage = MyDosage(context: moc)
                        dosage.amountToTake = dosageData["amount"] as! Double
                        dosage.timeToTake = dosageData["when"] as? String
                        
                        myDosageData.add(dosage)
                        med.addToRelMyDosage(myDosageData)
                    
                    }
                }
                
                // webSite   [webSiteURL, webSiteDesc]
                if let webSite = medData["webSite"] {
                    let webData = med.relWebSite?.mutableCopy() as! NSMutableSet
                    
                    for  webSiteDetail in webSite as! NSArray {
                        let webSiteData = webSiteDetail as! [String: AnyObject]
                        
                        let web = WebSite(context: moc)
                        web.url = webSiteData["webSiteURL"] as? String
                        web.desc = webSiteData["webSiteDesc"] as? String
                        
                        webData.add(web)
                        med.addToRelWebSite(webData)
                        
                    }
                }

                
                // sort  [default, fillboxes]
                if let sorts = medData["sort"] {
                    let sortsData = med.relSort?.mutableCopy() as! NSMutableSet
                    
                    for  sortDetail in sorts as! NSArray {
                        let sortData = sortDetail as! [String: AnyObject]
                        
                        let aSort = Sort(context: moc)
                        aSort.defaultSort = sortData["default"] as! Int32
                        aSort.fillBoxesSort = sortData["fillBoxes"] as! Int32
                        
                        sortsData.add(aSort)
                        med.addToRelSort(sortsData)
                        
                    }
                }

            }
            
            coreData.saveContext()
            
        } catch {
            fatalError("Cannot upload sample data")
        }
    }
}
