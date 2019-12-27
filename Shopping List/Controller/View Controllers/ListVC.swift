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
    var shoppingController: ShoppingController?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.shoppingController = ShoppingController()
        self.shoppingController?.makeShoppingList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension ListVC: UICollectionViewDelegate {
    
}

extension ListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shoppingController?.shoppingItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingItemCell", for: indexPath) as? ShoppingItemCell else {return UICollectionViewCell()}
        cell.item = shoppingController?.shoppingItems[indexPath.item]
        return cell
    }
    
    
}



