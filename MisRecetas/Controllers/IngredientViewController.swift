//
//  IngredientTableViewController.swift
//  MisRecetas
//
//  Created by Alicia Ngomo Fernandez on 02/04/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class IngredientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let realm = try! Realm()
    
    var ingredientsArray: Results<Ingredient>?
    var newReceta = Receta()
    
    @IBOutlet weak var ingredientTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTable.separatorStyle = .none
    }
    
    
    //MARK - TableView Datasource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
            
        cell.textLabel?.text = newReceta.ingredients[indexPath.row].name
        return cell
    }
    
    //MARK - Model manipulation methods
        
        func loadIngredients() {
            ingredientsArray = newReceta.ingredients.sorted(byKeyPath: "name")
            tableView.reloadData()
        }

}
