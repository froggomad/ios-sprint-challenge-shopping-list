//
//  ShoppingItemCell.swift
//  Shopping List
//
//  Created by Kenny on 12/27/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ShoppingItemCell: UICollectionViewCell {
    @IBOutlet weak var addedLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
        
    var shoppingController: ShoppingController?
    var item: ShoppingItem? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        //item is force unwrapped here because this isn't being called until didSet (item has a value)
        if let shoppingController = shoppingController {
            if shoppingController.itemNames.contains(item!.name) {
                imageView.image = UIImage(named: item!.name)
            }
        }
        
        self.nameLbl.text = item!.name
        if item!.wasPicked {
            addedLbl.text = "Added"
        } else {
            addedLbl.text = "Not Added"
        }
    }
}
