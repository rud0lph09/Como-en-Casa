//
//  AddCreditCard.swift
//  Como en Casa
//
//  Created by Jonathan Velazquez on 31/07/16.
//  Copyright © 2016 Rodolfo Castillo. All rights reserved.
//

import UIKit

class AddCreditCard: UIViewController, CardIOPaymentViewControllerDelegate {

    
    @IBOutlet weak var creditCardNumber: UILabel!
    @IBOutlet weak var expLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var tapGesture:UITapGestureRecognizer!
    
    override func viewDidLoad() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyBoard))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        CardIOUtilities.preload()
    }
    
    func hideKeyBoard() {
        self.view.endEditing(true)
    }
    
    
    @IBAction func nextView(sender: UIButton) {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC.modalPresentationStyle = .FullScreen
        presentViewController(cardIOVC, animated: true, completion: nil)
    }
    
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        creditCardNumber.text = ""
        if let info = cardInfo {
            var i = 0;
            for c in info.cardNumber.characters {
                if i%4 == 0 {
                    creditCardNumber.text = creditCardNumber.text!+"  "
                }
                creditCardNumber.text = creditCardNumber.text! + "\(c)"
                i++
            }
            
            //creditCardNumber.text = info.cardNumber
            expLabel.text = "\(info.expiryMonth) / \(info.expiryYear)"
            nameLabel.text = "Rodolfo Castillo Vidrio"
        }
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
