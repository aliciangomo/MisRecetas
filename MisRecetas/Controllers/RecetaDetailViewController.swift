//
//  AddViewController.swift
//  MisRecetas
//
//  Created by Alicia Ngomo Fernandez on 02/04/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class RecetaDetailViewController: UIViewController {

    
    let realm = try! Realm()
    
    var selectedReceta : Receta?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
            
        guard let navBar = navigationController?.navigationBar else {fatalError("Fatal error")}
            
                
        if let navBarcolour = UIColor(hexString: K.BrandColors.beige) {
            navBar.barTintColor = navBarcolour
            navBar.tintColor = ContrastColorOf(navBarcolour, returnFlat: true)
            navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarcolour, returnFlat: true)]
            }
          
    }

    //MARK - TableView Delegate Methods
        
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        if let item = selectedReceta?.ingredients[indexPath.row] {
    //            do{
    //            try realm.write {
    //                item.done = !item.done
    //            }
    //            } catch {
    //                print(error)
    //            }
    //
    //            tableView.reloadData()
    //            tableView.deselectRow(at: indexPath, animated: true)
    //
    //        }
    //    }
    
    //MARK - Add new item
        
    //    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    //
    //        var textField = UITextField()
    //
    //        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
    //
    //        let action = UIAlertAction(title: "Add item", style: .default) {(action) in
    //            if let currentCategory = self.selectedCategory {
    //                do {
    //                    try self.realm.write {
    //                        let newItem = Item()
    //                        newItem.title = textField.text!
    //                        currentCategory.items.append(newItem)
    //                    }
    //                } catch {
    //                    print(error)
    //                }
    //            }
    //            self.tableView.reloadData()
    //        }
    //
    //        alert.addTextField { (alertTextField) in
    //        alertTextField.placeholder = "Create new item"
    //        textField = alertTextField
    //        }
    //
    //        alert.addAction(action)
    //
    //        present(alert, animated: true, completion: nil)
    //    }

    //MARK - Model manipulation methods
        
    //    func loadItems() {
    //        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title")
    //        tableView.reloadData()
    //    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
