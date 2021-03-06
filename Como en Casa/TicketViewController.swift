//
//  TicketViewController.swift
//  Como en Casa
//
//  Created by Rodolfo Castillo on 7/30/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit
import NAExpandableTableController

import Alamofire
import SwiftyJSON


enum foodSectionState {
    case Postre,Comida;
}

class TicketViewController: UIViewController, NAExpandableTableViewDelegate, NAExpandableTableViewDataSource{

    @IBOutlet weak var tb: UITableView!
    
    
    
    let numberOfSections = 6
    let numberOfRowsInEachSection = [Int]()
    let expandableSectionIndices = [2,3]
    var food:foodSectionState = .Comida
    
    
    var expandableTableController: NAExpandableTableController!
    
    override func viewDidLoad() {
        
        expandableTableController = NAExpandableTableController(dataSource: self, delegate: self)
        expandableTableController.exclusiveExpand = true
        tb.delegate = expandableTableController
        tb.dataSource = expandableTableController
        //recoveryData()
    }
    
    
    func recoveryData() {
//        let orderWrap:[String: AnyObject] = NSUserDefaults.standardUserDefaults().valueForKey("lastOrder") as! [String: AnyObject]
//        let order = (orderWrap["orders"] as! [[String:String]])
//        
//        var sopas = [[String:String]]()
//        var entradas = [[String:String]]()
//        var platosFuerte = [[String:String]]()
//        var bebidas = [[String:String]]()
//        var postres = [[String:String]]()
//        
//        for i in order {
//            switch i[""] {
//            case <#pattern#>:
//                <#code#>
//            default:
//                <#code#>
//            }
//        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
    }
    
    func numberOfSectionsInExpandableTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func expandableTableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func expandableTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tb.dequeueReusableCellWithIdentifier("TicketDescriptionCell") as! TicketDescriptionCell
        if indexPath.row == 0 {
            cell.setCell(1, description: "Sopa Papa, Mole.", price: 30)
        }else{
            cell.setCell(1, description: "Arroz, Milanesa.", price: 30)

        }
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
        
    func expandableTableView(tableView: UITableView, didSelectTitleCellInSection section: Int) {
        if section == 2 {
            food = .Comida
        }else if section == 3{
            food = .Postre
        }
    }
    
    func animateNotif(){
        let notif = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        notif.center = self.view.center
        notif.backgroundColor = UIColor.blackColor()
        notif.clipsToBounds = true
        notif.layer.cornerRadius = 10
        notif.textAlignment = .Center
        notif.alpha = 0
        notif.font = UIFont(name: "Avenir-Next", size: 35)
        notif.textColor = UIColor.whiteColor()
        notif.text = "Listo!"
        
        self.view.addSubview(notif)
        
        notif.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animateWithDuration(0.2, animations: {
            notif.alpha = 0.7
            notif.transform = CGAffineTransformIdentity
        })
        
        UIView.animateWithDuration(0.2, delay: 0.9, options: [], animations: {
            notif.transform = CGAffineTransformMakeScale(0.1, 0.1)
            notif.alpha = 0
            }) { (finished) in
                self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    
    @IBAction func creditCardPay(sender: UIButton) {
        Alamofire.request(.POST, "https://comoencasaapp.herokuapp.com/addorder",parameters: ["response":"succed"]).responseData { response in
            let json = JSON(response.data!)
            print(json.description)
            
            self.animateNotif()
            
        }
    }
    
    @IBAction func cancelOrder(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
