//
//  ShoppingDetailVC.swift
//  Shopping List
//
//  Created by Kenny on 12/27/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ShoppingDetailVC: UIViewController {
    
    @IBOutlet weak var shoppingLbl: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBAction func deliveryBtnTapped(_ sender: UIButton) {
        submitDelivery()
    }
    
    
    var items: [ShoppingItem]?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews() //using didSet pattern, label is nil
        nameTextField.delegate = self
        addressTextField.delegate = self
    }
    
    func setupViews() {
        guard let items = items else {return}
        if items.count > 0 {
            self.shoppingLbl.text = "Please enter your name and address below, so we can deliver your \(items.count) items."
        }
    }
    
    func submitDelivery() {
        if nameTextField.text == "" {
            Alert.show(title: "Oops!", message: "Please enter your name", vc: self)
        }
        if addressTextField.text == "" {
            Alert.show(title: "Oops!", message: "Please enter your address so we can deliver you item(s)!", vc: self)
        }
        Alert.show(title: "Delivery Scheduled!", message: "Your Delivery is scheduled for 15 seconds from now. Hold tight!", vc: self)
    }
}

extension ShoppingDetailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            textField.resignFirstResponder()
            switch textField {
            case nameTextField:
                addressTextField.becomeFirstResponder()
            case addressTextField:
                submitDelivery()
            default:
                break
            }
            return true
        }
        return false
    }
}
