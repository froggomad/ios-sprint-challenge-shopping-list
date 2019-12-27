//
//  Shopping Controller.swift
//  Shopping List
//
//  Created by Kenny on 12/27/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class ShoppingController {
    let itemNames = ["Apple", "Grapes", "Milk", "Muffin", "Popcorn", "Soda", "Strawberries"]
    var shoppingItems: [ShoppingItem] = []
    
    func makeShoppingList() {
        //loading from persistent store first to avoid having to use and check UserDefaults
        loadFromPersistentStore()
        if shoppingItems.count == 0 {
            for name in itemNames {
                shoppingItems.append(ShoppingItem(name: name))
            }
        }
        saveToPersistentStore()
    }
          
    var fileLocation: URL? {
        let fileManager = FileManager.default
        //unwrap directory
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        //append books.plist to documentDirectory to create file at path (URL)
        let fileUrl = documentDirectory.appendingPathComponent("shoppingItems.plist")
        return fileUrl
    }
    
    var pickedItems: [ShoppingItem] {
        return shoppingItems.filter {$0.wasPicked == true}
    }
    
    
    //MARK: Read
    func loadFromPersistentStore() {
        guard let fileURL = fileLocation else {return}
        
        do {
            let shoppingData = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            let shoppingArray = try decoder.decode([ShoppingItem].self, from: shoppingData)
            self.shoppingItems = shoppingArray
        } catch {
            print("Error loading items from plist: \(error)")
        }
    }
    
    //MARK: Update
    func pickItem(forShoppingItem item: ShoppingItem) {
        if let index = shoppingItems.firstIndex(of: item) {
            shoppingItems[index].wasPicked = !shoppingItems[index].wasPicked
            saveToPersistentStore()
        }
    }
    
    private func saveToPersistentStore() {
        //check to make sure file url exists
        guard let fileURL = fileLocation else { return }
        do {
            let encoder = PropertyListEncoder()
            //use plist encoder to write desk file
            let shoppingData = try encoder.encode(shoppingItems)
            try shoppingData.write(to: fileURL)
        } catch {
            print("Error Saving Shopping List: \(error)")
        }
    }
    
}
