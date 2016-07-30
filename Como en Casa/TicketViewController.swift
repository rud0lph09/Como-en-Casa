//
//  TicketViewController.swift
//  Como en Casa
//
//  Created by Rodolfo Castillo on 7/30/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit
import NAExpandableTableController


class TicketViewController: UIViewController, NAExpandableTableViewDelegate, NAExpandableTableViewDataSource{

    @IBOutlet weak var tb: UITableView!
    
    let numberOfSections = 6
    let numberOfRowsInEachSection = [Int]()
    let expandableSectionIndices = [2,3]
    
    var expandableTableController: NAExpandableTableController!
    
    override func viewDidLoad() {
        
        expandableTableController = NAExpandableTableController(dataSource: self, delegate: self)
        expandableTableController.exclusiveExpand = true
        
        tb.delegate = expandableTableController
        tb.dataSource = expandableTableController
    }
    
    
    func numberOfSectionsInExpandableTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func expandableTableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func expandableTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tb.dequeueReusableCellWithIdentifier("TicketDescriptionCell") as! TicketDescriptionCell
        cell.setCell(2, description: "Lorem ipsum", price: 40)
        print(indexPath.row)
        return cell
    }
    
    
    func expandableTableView(tableView: UITableView, titleCellForSection section: Int, expanded: Bool) -> UITableViewCell {
        switch section {
        case 0:
            let cell = tb.dequeueReusableCellWithIdentifier("TicketBorderCell") as! TicketBorderCell
            cell.setCell(.Up)
            cell.userInteractionEnabled = false
            return cell
        case 1:
            let cell = tb.dequeueReusableCellWithIdentifier("TicketTitleCell")
            cell!.userInteractionEnabled = false
            return cell!
        case 2:
            let cell = tb.dequeueReusableCellWithIdentifier("TicketSectionCell") as! TicketSectionCell
            cell.setCell(1, description: "Menu del día", price: 60)
            return cell
        case 3:
            let cell = tb.dequeueReusableCellWithIdentifier("TicketSectionCell") as! TicketSectionCell
            cell.setCell(2, description: "Postre", price: 60)
            return cell
        case 4:
            let cell = tb.dequeueReusableCellWithIdentifier("TicketTotalCell") as! TicketTotalCell
            cell.userInteractionEnabled = false
            cell.setCell(120)
            return cell
        default:
            let cell = tb.dequeueReusableCellWithIdentifier("TicketBorderCell") as! TicketBorderCell
            cell.userInteractionEnabled = false
            cell.setCell(.Down)
            return cell
        }
    }
    
    func expandableTableView(tableView: UITableView, isExpandableSection section: Int) -> Bool {
        return true
    }
    
    
    
}
