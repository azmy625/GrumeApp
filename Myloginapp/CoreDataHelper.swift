//
//  CoreDataHelper.swift
//  Travel Log
//
//  Created by Dion Larson on 8/27/18.
//  Copyright © 2018 Dion Larson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newTravelItem() -> TravelItem {
        let travelItem = NSEntityDescription.insertNewObject(forEntityName: "TravelItem", into: context) as! TravelItem
        return travelItem
    }
    
    static func save() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(travelItem: TravelItem) {
        context.delete(travelItem)
        save()
    }
    
    static func retrieveTravelItems() -> [TravelItem] {
        do {
            let fetchRequest = NSFetchRequest<TravelItem>(entityName: "TravelItem")
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Could not retrieve \(error.localizedDescription)")
            return []
        }
    }
}
