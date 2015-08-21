
//
//  DAO.swift
//
//  Created by Wendel Silva on 13/07/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

/*
*** EXTENSION PARA MANAGEDOBJECT E ENTITY DESCRIPTION, AGILIZANDO CRUD NO COREDATA ***
*/

import UIKit
import CoreData

extension NSEntityDescription {
    
    class func insertNewObjectForEntityForName (entityName: String) -> NSManagedObject {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        return self.insertNewObjectForEntityForName(entityName, inManagedObjectContext: managedObjectContext!) as! NSManagedObject
    }
}

extension NSManagedObject {
    
    static func getManagedObjectContext() -> NSManagedObjectContext {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    }
    
    class func saveOrUpdate() -> Bool {
        
        var error : NSError? = nil
        let managedObjectContext = self.getManagedObjectContext()
        let retorno = managedObjectContext.save(&error)
        
        if(retorno == false){
            print("ERRO: \(error!.description)")
        }
        
        return retorno
    }
    
    class func deleteObject(object: NSManagedObject) -> Bool {
        
        
        var error : NSError? = nil
        let managedObjectContext = self.getManagedObjectContext()
        
        managedObjectContext.deleteObject(object)
        let retorno = managedObjectContext.save(&error)
        
        if(retorno == false){
            print("ERRO: \(error!.description)")
        }
        
        return retorno
    }
    
    class func arrayObject(columnNameToSort: String, ascending: Bool = true) -> [NSManagedObject] {
        
        var arrayManagedObject  = [NSManagedObject]()
        let entityName = description().componentsSeparatedByString(".").last
        let managedObjectContext = self.getManagedObjectContext()
        
        
        let fetchRequest = NSFetchRequest(entityName: entityName!)
        let sortDescriptor = NSSortDescriptor(key: columnNameToSort, ascending: ascending)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as? [NSManagedObject]{
            arrayManagedObject = fetchResults
        }
        return arrayManagedObject
    }
    
    class func fetchedResultsController(columnNameToSort: String, ascending: Bool = true) -> NSFetchedResultsController {
        
        let entityName = description().componentsSeparatedByString(".").last
        
        let managedObjectContext = self.getManagedObjectContext()
        let fetchRequest = NSFetchRequest(entityName: entityName!)
        let sortDescriptor = NSSortDescriptor(key: columnNameToSort, ascending: ascending)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }
}
