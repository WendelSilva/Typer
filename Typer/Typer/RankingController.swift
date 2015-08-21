//
//  RankingController.swift
//  FastFingers
//
//  Created by Wendel Silva on 19/08/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class RankingController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var arrayRank = [Rank]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.arrayRank = RankDAO.listAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - TABLEVIEW DELEGATE
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ranking"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        let rank = self.arrayRank[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row + 1) - \(rank.name!)"
        cell.detailTextLabel?.text = rank.totalPoints!.stringValue
        
        if(indexPath.row % 2 == 1){
            cell.backgroundColor = UIColor(red: 238/255, green: 221/255, blue: 62/255, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.clearColor()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayRank.count
    }

}
