//
//  ViewController.swift
//  iOSLibraryIntegrationDemo
//
//  Created by John Lima on 26/12/17.
//  Copyright © 2017 limadeveloper. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, CardIOPaymentViewControllerDelegate {

    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CardIOUtilities.preload()
        updateUI()
    }
    
    @IBAction private func scan() {
        guard let controller = CardIOPaymentViewController(paymentDelegate: self) else { return }
        controller.modalPresentationStyle = .formSheet
        present(controller, animated: true, completion: nil)
    }
    
    private func updateUI() {
        imageView.af_setImage(withURL: URL(string: "https://i.pinimg.com/736x/53/c8/b9/53c8b9d9393088c2aeffea99fe95a09d--star-wars-jedi-star-wars-art.jpg")!)
    }
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        print("user did cancel")
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            let string = NSString(format: "Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            print(" card info: \(string)")
        }
        paymentViewController.dismiss(animated: true, completion: nil)
    }
}

