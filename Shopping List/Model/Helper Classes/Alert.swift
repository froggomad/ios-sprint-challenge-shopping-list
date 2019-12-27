//
//  Alert.swift
//  Shopping List
//
//  Created by Kenny on 12/27/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

import UIKit

class Alert {
    class func show(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}
