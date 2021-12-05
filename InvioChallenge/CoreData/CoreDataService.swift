//
//  CoreDataService.swift
//  InvioChallenge
//
//  Created by Oktay Tanrıkulu on 5.12.2021.
//

import UIKit
import CoreData

final class CoreDataService {
    
    var appDelegate: AppDelegate
    var context: NSManagedObjectContext
    
    private init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    static var sharedInstance: CoreDataService = {
        return CoreDataService()
    }()
    
}

extension CoreDataService {
    
    func getLastTitle() -> String? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LastSearchTitle")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let title = result.value(forKey: "title") as? String {
                    return title
                }
            }
        } catch {
            print("Error")
        }
        
        return nil
    }
    
    func saveLastTitle(with title: String) {
        let entity = NSEntityDescription.entity(forEntityName: "LastSearchTitle", in: context)!
        let item = NSManagedObject(entity: entity, insertInto: context)
        item.setValue(title, forKey: "title")
        
        do {
            try context.save()
        } catch let error {
            print("Item can't be created: \(error.localizedDescription)")
        }
    }
    
}

