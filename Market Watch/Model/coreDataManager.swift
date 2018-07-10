//
//  coreDataManager.swift
//  Market Watch
//
//  Created by Vishwas Mukund on 7/7/18.
//  Copyright © 2018 Vishwas Mukund. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class coreDataManager {
    
    // Function to save data into core data
    func saveData(inputString:String){
        DispatchQueue.main.async {
            let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate);
            let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
            let symbol = NSEntityDescription.insertNewObject(forEntityName: "Symbols",into: context) as! Symbols
            symbol.smybolName = inputString;
            do{
                try context.save()
            }catch {
                print("Core Data Error !")
                abort()
            }
        }
    }
    
    //Function that deletes data from core data
    func deleteData(inputString: String){
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate);
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
        }catch{
            print("Core Data error");
        }
    }
    
    //Function that fetchs all data in core Data Entity.
    func getAllResults() -> [String]{
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate);
        var savedSymbols = [String]();
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Symbols");
        fetchRequest.returnsObjectsAsFaults = false
        var result : [AnyObject]? = nil;
        do {
            result = try context.fetch(fetchRequest) as [AnyObject]
            for i in result as! [Symbols] {
                savedSymbols.append(i.smybolName!);
            }
        }catch{
            print("Error fetching data from CoreData");
        }
        return savedSymbols;
    }
}
