//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Alicia Ngomo Fernandez on 28/03/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class RecetasViewController: SwipeTableViewController, UISearchBarDelegate {

    let realm = try! Realm()
    
    var recetasArray: Results<Receta>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadRecetas()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {fatalError("Fatal error")}
        navBar.backgroundColor = UIColor(hexString: K.BrandColors.beige)
    }

    //MARK - TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recetasArray?.count ?? 1
    }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let receta = recetasArray?[indexPath.row] {
        
        cell.textLabel?.text = receta.name
        cell.imageView?.image = UIImage()
//        cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        }
        return cell
    }
    
    
    //MARK - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToReceta", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RecetaDetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedReceta = recetasArray?[indexPath.row]
        }
    }
    
    
    //MARK - Data Manipulation methods
    
    func save(receta: Receta) {
        do {
            try realm.write {
                realm.add(receta)
            }
        } catch {
            print("Error saving receta \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    func loadRecetas() {
        recetasArray = realm.objects(Receta.self).sorted(byKeyPath: "name")
        tableView.reloadData()

    }
    
    
    //MARK - Delete Data from Swipe
    
    override func updateModel (at indexPath: IndexPath) {
        if let recetaForDeletion = self.recetasArray?[indexPath.row] {
        do {
            try self.realm.write {
                self.realm.delete(recetaForDeletion)
            }
        } catch {
            print(error)
        }
        
        }
    }
    
    //MARK - Add New Recetas

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "AddReceta", sender: self)
    }
    
    //MARK - SearchBar delegate methods
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        recetasArray = recetasArray?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
        tableView.reloadData()
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadRecetas()

            DispatchQueue.main.async{
                searchBar.resignFirstResponder()
            }
        }

    }

}


