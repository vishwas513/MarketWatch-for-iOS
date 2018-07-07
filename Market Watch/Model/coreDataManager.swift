//
//  coreDataManager.swift
//  Market Watch
//
//  Created by Vishwas Mukund on 7/4/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class coreDataManager {
    var appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate);
   
    func saveData(inputString:String){
        
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let symbol = NSEntityDescription.insertNewObject(forEntityName: "Symbols",into: context) as! Symbols
        symbol.smybolName = inputString;
        
        do{
            try context.save()
            print("Saved into Core Data")
        }catch {
            print("Core Data Error !")
            abort()
        }
        
    }
    
    func deleteData(inputString: String){
        
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Symbols");
        fetchRequest.predicate=NSPredicate(format: "smybolName = %@", inputString);
        var result = [Symbols]();
        
        do {
            //fetch request for delete
            result = try context.fetch(fetchRequest) as! [Symbols]
            
            for i in result{
                // Delete from Core Data
                context.delete(i);
            }
            
            // Save Core Data context
            try context.save();
            print("Deleted")
        }catch{
            print("Core Data error");
        }
    }
    
    func getAllResults() -> [String]{
        
        var savedSymbols = [String]();
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Symbols");
        fetchRequest.returnsObjectsAsFaults = false
        var result : [AnyObject]? = nil;
        
        do {
            result = try context.fetch(fetchRequest) as [AnyObject]
            for i in result as! [Symbols] {
                savedSymbols.append(i.smybolName as! String);
            }
        }catch{
            print("Error fetching data from CoreData");
        }
        return savedSymbols;
    }
}
