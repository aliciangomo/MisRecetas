//
//  IngredientTableViewController.swift
//  MisRecetas
//
//  Created by Alicia Ngomo Fernandez on 02/04/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData



class IngredientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var ingredientsArray = [Ingredient]()
    
    var newReceta : Receta? {
        didSet{
            loadIngredients()
        }
    }
    
    @IBOutlet weak var ingredientTable: UITableView!
    @IBOutlet weak var addIngredientButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadIngredients()
        ingredientTable.separatorStyle = .none
    }
    
    
    //MARK: - TableView Datasource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        
        cell.textLabel?.text = "\(String(describing: ingredientsArray[indexPath.row].name)) - \(String(describing: ingredientsArray[indexPath.row].dose?.measure)) \(String(describing: ingredientsArray[indexPath.row].dose?.amount)) "
        return cell
    }
    
    //MARK: - Model manipulation methods
    
    func loadIngredients(with request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest(), predicate: NSPredicate? = nil) {
        
            do {
                ingredientsArray = try context.fetch(request)
            } catch {
                print(error)
            }
        
        if ingredientsArray != [] {
        self.ingredientTable.reloadData()
        }
    }
    

    func saveIngredient(ingredient: Ingredient){
        do {
            try context.save()
        } catch {
            print(error)
        }
        ingredientTable.reloadData()
    }

    //MARK: - Add new ingredient

    @IBAction func addIngredientPressed(_ sender: UIButton) {
        
        var nameTextField = UITextField()
        var measureTextField = UITextField()
        var amountTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new ingredient", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add ingredient", style: .default) {(action) in
            let currentReceta = self.context.object(with: self.newReceta!.objectID)
            
            let newIngredient = Ingredient(context: self.context)
            newIngredient.name = nameTextField.text!
            newIngredient.parentReceta = currentReceta as? Receta
            let newDose = Dose(context: self.context)
            newDose.measure = measureTextField.text!
            newDose.amount = amountTextField.text!
            newIngredient.dose = newDose
            self.ingredientsArray.append(newIngredient)
            
            self.saveIngredient(ingredient: newIngredient)
            
        }
    
    alert.addTextField { (name) in
    name.placeholder = "Nombre"
    nameTextField = name
    }
    
    alert.addTextField { (measure) in
    measure.placeholder = "Medida"
    measureTextField = measure
    }
    
    alert.addTextField { (amount) in
    amount.placeholder = "Cantidad"
    amountTextField = amount
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
}

}

