//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Alicia Ngomo Fernandez on 28/03/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit


class RecetasViewController: UITableViewController, UISearchBarDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recetasArray = [Receta]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadRecetas()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 100.0
        tableView.separatorStyle = .none
        
    }
    

    //MARK: - TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recetasArray.count
    }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
        
        let receta = recetasArray[indexPath.row]
        
        cell.textLabel?.text = receta.name
        cell.imageView?.image = UIImage(named: "appstore")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
          guard orientation == .right else { return nil }
          
          let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
              
              self.updateModel(at: indexPath)
                  
              }
              
          deleteAction.image = UIImage(named: "delete-icon")
          
          return [deleteAction]
      }
      
      
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
          var options = SwipeOptions()
          options.expansionStyle = .destructive
          return options
      }
    
    
    //MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowReceta", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowReceta") {
            let destinationVC = segue.destination as! RecetaDetailViewController
                
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedReceta = recetasArray[indexPath.row]
            }
        }
        
    }
    
    //MARK: - Data Manipulation methods
    
    func save(receta: Receta) {
        do {
            try context.save()
        } catch {
            print("Error saving receta \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    func loadRecetas(with request: NSFetchRequest<Receta> = Receta.fetchRequest(), predicate: NSPredicate? = nil) {
        
        do {
            recetasArray = try context.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()

    }
    
    
    //MARK: - Delete Data from Swipe
    
   func updateModel (at indexPath: IndexPath) {
        do {
            context.delete(recetasArray[indexPath.row])
            recetasArray.remove(at: indexPath.row)
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    
    
    //MARK: - SearchBar delegate methods
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Receta> = Receta.fetchRequest()

        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        loadRecetas(with: request, predicate: predicate)
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadRecetas()

            DispatchQueue.main.async{
                searchBar.resignFirstResponder()
            }
        }

    }
    
//    MARK: - Add receta
    
    
    @IBAction func addReceta(_ sender: UIBarButtonItem) {
    }
    
}

//extension RecetasViewController : AddRecetaDelegate {
//    func addReceta(receta: Receta) {
//        self.recetasArray.append(receta)
//        self.tableView.reloadData()
//}
//}
