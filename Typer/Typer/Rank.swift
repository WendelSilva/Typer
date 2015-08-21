//
//  Rank.swift
//  Typer
//
//  Created by Wendel Silva on 21/08/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import Foundation
import CoreData

class Rank: NSManagedObject {

    @NSManaged var name: String?
    @NSManaged var totalHits: NSNumber?
    @NSManaged var totalErrors: NSNumber?
    @NSManaged var totalPoints: NSNumber?
    
}