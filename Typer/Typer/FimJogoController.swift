//
//  FimJogoController.swift
//  FastFingers
//
//  Created by Wendel Silva on 19/08/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit
import CoreData

class FimJogoController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblTotalHits: UILabel!
    @IBOutlet weak var lblTotalErrors: UILabel!
    @IBOutlet weak var lblTotalPoints: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var playerName : String!
    var totalHits : NSNumber!
    var totalErrors : NSNumber!
    var totalPoints : NSNumber!
    
    var fetchedResultController : NSFetchedResultsController!
    
    var indexPath : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //OBTER ARRAY DE RANKING
        var error : NSError? = nil
        self.fetchedResultController = RankDAO.fetchResultsByTotalPointsDesc()
        self.fetchedResultController.delegate = self
        self.fetchedResultController.performFetch(&error)
        
        if(error != nil){
            print("ERRO. \(error!.description)")
        }
        
        //OBTER DADOS DO JOGO FINALIZADO
        self.lblPlayerName.text! = self.playerName
        self.lblTotalHits.text! = self.totalHits.stringValue
        self.lblTotalErrors.text! = self.totalErrors.stringValue
        self.lblTotalPoints.text! = self.totalPoints.stringValue
        
        if(self.totalPoints.integerValue > 0){
            RankDAO.saveRank(self.playerName, totalHits: self.totalHits, totalErrors: self.totalErrors, totalPoints: self.totalPoints)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //FETCH CONTROLLER DELEGATE
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        self.fetchedResultController.performFetch(nil)
        
        self.tableView.beginUpdates()
        
        switch (type) {
        case .Insert:
            
            self.indexPath = newIndexPath!
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Top)
            
            break;
            
        case .Delete:
            
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Bottom)
            break;
            
        case .Update:
            
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.None)
            break;
            
        case .Move:
            
            self.tableView.reloadRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Top)
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Bottom)
            break;
        }
        
        self.tableView.endUpdates()
    }
    
    
    //MARK: - TABLEVIEW DELEGATE
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultController.sections?.count as Int!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = self.fetchedResultController.sections as! [NSFetchedResultsSectionInfo]!
        return sections[section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ranking"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(self.indexPath?.row == indexPath.row ? "newRankCell" : "cell", forIndexPath: indexPath) as! UITableViewCell
        
        let rank = self.fetchedResultController.objectAtIndexPath(indexPath) as! Rank
        
        cell.textLabel!.text = "\(indexPath.row + 1) - \(rank.name!)"
        cell.detailTextLabel!.text = rank.totalPoints!.stringValue
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete) {
            
            let rank = self.fetchedResultController.objectAtIndexPath(indexPath) as! Rank
            RankDAO.deleteRank(rank)
        }
    }
    
}
