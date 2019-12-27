//
//  ViewController.swift
//  Shopping List
//
//  Created by Spencer Curtis on 8/3/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIBarButtonItem!
    
    
    var shoppingController: ShoppingController?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.shoppingController = ShoppingController()
        self.shoppingController?.makeShoppingList()
        checkPicked()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListDetailSegue" {
            guard let detailVC = segue.destination as? ShoppingDetailVC else {print("not the destination");return}
            detailVC.items = shoppingController?.pickedItems
        }
    }
    
    //MARK: Helper Functions
    func checkPicked() {
        if let pickedItems = shoppingController?.pickedItems.count {
            if pickedItems > 0 {
                nextBtn.isEnabled = true
            } else {
                nextBtn.isEnabled = false
            }
        }
    }
    
}

extension ListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShoppingItemCell,
              let item = cell.item else {return}
        shoppingController?.pickItem(forShoppingItem: item)
        checkPicked()
        collectionView.reloadData()
    }
}

extension ListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shoppingController?.shoppingItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingItemCell", for: indexPath) as? ShoppingItemCell else {return UICollectionViewCell()}
        cell.shoppingController = shoppingController
        cell.item = shoppingController?.shoppingItems[indexPath.item]
        return cell
    }
    
}



