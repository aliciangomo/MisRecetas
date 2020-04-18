//
//  AddViewController.swift
//  MisRecetas
//
//  Created by Alicia Ngomo Fernandez on 02/04/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData


class RecetaDetailViewController: UIViewController {

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var selectedReceta : Receta?

    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var nameShow: UILabel!
    @IBOutlet weak var linkShow: UILabel!
    @IBOutlet weak var pasosShow: UILabel!
    @IBOutlet weak var ingredientsListShow: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameShow.text = selectedReceta?.name
        linkShow.text = selectedReceta?.link
        pasosShow.text = selectedReceta?.pasos
        
        showIngredients()
    }
    
    func showIngredients() {
        performSegue(withIdentifier: "showIngredients", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowIngredients") {
        let request : NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        let predicate = NSPredicate(format: "parentReceta.name MATCHES %@", selectedReceta!.name!)
        let vc = segue.destination as! IngredientViewController
        vc.loadIngredients(with: request, predicate: predicate)
        }
    }

}
