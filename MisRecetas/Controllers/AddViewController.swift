//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class AddViewController: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm()
    
    var newReceta = Receta()
    
    @IBOutlet weak var recetaImage: UIImageView!
    @IBOutlet weak var recetaName: UITextField!
    @IBOutlet weak var recetaLink: UITextField!
    @IBOutlet weak var ingredientsContainer: UIView!
    @IBOutlet weak var recetaPasos: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recetaName.delegate = self
        recetaLink.delegate = self
        recetaPasos.delegate = self
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let navBar = navigationController?.navigationBar else {fatalError("Fatal error")}
        
        if let navBarcolour = UIColor(hexString: K.BrandColors.beige) {
            navBar.barTintColor = navBarcolour
            navBar.tintColor = ContrastColorOf(navBarcolour, returnFlat: true)
            navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarcolour, returnFlat: true)]
        }
    }
      
    func textFieldDidEndEditing(_ textField: UITextField) {
        newReceta.name = recetaName.text ?? ""
        newReceta.link = recetaLink.text ?? ""
        newReceta.instructions = recetaPasos.text ?? ""
        
    
    }
    
    
    
//    https://stackoverflow.com/questions/29582200/how-do-i-get-the-views-inside-a-container-in-swift
    
    func performSegue(withIdentifier: "GoToIngredients", sender: self) {
        
         
    }
        
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as! IngredientViewController
            vc.newReceta =
            if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedReceta = recetasArray?[indexPath.row]
        }
        
        
        
    }
 
   
    
    
    
    
    
//MARK - TableView Datasource Methods
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return selectedReceta?.ingredients.count ?? 1
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = super.tableView(tableView, cellForRowAt: indexPath)
//
//        if let item = selectedReceta?.ingredients[indexPath.row] {
//
//            cell.textLabel?.text = item.title
//
//        } else {
//            cell.textLabel?.text = "No ingredienst added"
//        }
//        return cell
//    }
    
    
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
    
    
//MARK - Delete an item
//
//    override func updateModel(at indexPath: IndexPath) {
//        if let itemForDeletion = self.toDoItems?[indexPath.row] {
//        do {
//            try self.realm.write {
//                self.realm.delete(itemForDeletion)
//            }
//        } catch {
//            print(error)
//        }
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
    
        
//MARK - SEarch Bar delegate methods
        
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
//        tableView.reloadData()
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async{
//                searchBar.resignFirstResponder()
//            }
//        }
//
//    }
    

