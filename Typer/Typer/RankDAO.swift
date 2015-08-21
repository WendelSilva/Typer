//
//  RankDAO.swift
//  Typer
//
//  Created by Wendel Silva on 21/08/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import Foundation
import CoreData

@objc(Rank)
class RankDAO: Rank {
    
    // Insert code here to add functionality to your managed object subclass

    class func saveRank(name: String, totalHits: NSNumber, totalErrors: NSNumber, totalPoints: NSNumber){
        
        let rank = NSEntityDescription.insertNewObjectForEntityForName("Rank") as! Rank
        rank.name = name
        rank.totalHits = totalHits
        rank.totalErrors = totalErrors
        rank.totalPoints = totalPoints
        
        if (!self.saveOrUpdate()) {
            print("ERROR IN SAVE RANK.")
        }
    }
    
    class func deleteRank(rank: Rank){
        
        if (!self.deleteObject(rank)) {
            print("ERROR IN SAVE RANK.")
        }
    }
    
    class func listAll() -> [Rank]{
        
        return self.arrayObject("totalPoints", ascending: false) as! [Rank]
    }
    
    class func fetchResultsByTotalPointsDesc() -> NSFetchedResultsController {
        
        return self.fetchedResultsController("totalPoints", ascending: false)
    }
    
}
