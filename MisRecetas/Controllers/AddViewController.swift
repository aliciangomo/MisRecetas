//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData




class AddViewController: UIViewController, UITextFieldDelegate {

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var newReceta = Receta()
    
    
    @IBOutlet weak var recetaName: UITextField!
    @IBOutlet weak var recetaLink: UITextField!
    @IBOutlet weak var recetaPasos: UITextField!
    @IBOutlet weak var ingredientsContainer: UIView!
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))

    
        setInitViews()
        
    }
    
    func setInitViews() {
        recetaName.becomeFirstResponder()
        recetaName.delegate = self
        recetaLink.delegate = self
        recetaPasos.delegate = self
    
    }
    
    
//    MARK: - Selectors
    
    @objc func handleDone() {
        
        if recetaName.text!.isEmpty {
                   let alert = UIAlertController(title: nil, message: "No olvides el nombre de tu receta", preferredStyle: .alert)
                   let action = UIAlertAction(title: "Title", style: .default) { (action) in
                       self.dismiss(animated: true, completion: nil)
                   }
                   alert.addAction(action)
                   self.present(alert, animated: true, completion: nil)
               }
            else if(recetaLink.text?.isEmpty ?? false || recetaPasos.text?.isEmpty ?? false){
                let alert = UIAlertController(title: nil, message: "Agrega o un link o los pasos de la receta", preferredStyle: .alert)
                let action = UIAlertAction(title: "Content", style: .default) { (action) in
                    self.dismiss(animated: true, completion: nil)
                }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let newReceta = Receta(context: context)
            newReceta.name = recetaName.text!
            newReceta.link = recetaLink.text!
            newReceta.pasos = recetaPasos.text!

            save(receta: newReceta)
        }
    }
    

//    @objc func handleCancel() {
//        self.dismiss(animated: true, completion: nil)
//    }


    
    //MARK: - TextField Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        
        return true
    }


    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.text = ""
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            textField.resignFirstResponder()
            return true
        } else{
            textField.placeholder = "Type something"
            return false
        }
    }

    
    //MARK: - Data manipulation methods
    

    func save(receta: Receta) {
        do {
            try context.save()
        } catch {
            print("Error saving receta \(error.localizedDescription)")
        }

    }
    
//    @IBAction func addRecetaPressed(_ sender: UIButton,_ data: Data) {
//
////        if let imageData = recetaImage.image?.pngData() {
//            let newReceta = Receta(context: context)
////            newReceta.image = imageData
//            newReceta.name = recetaName.text!
//            newReceta.link = recetaLink.text!
//            newReceta.pasos = recetaPasos.text!
//
//            do {
//                try context.save()
//            } catch {
//                print("Error saving receta \(error.localizedDescription)")
//            }
//        }
        
        
    //MARK: - Perform segue
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoToIngredients") {
            if let VC = segue.destination as? IngredientViewController {
                    VC.newReceta = newReceta
            }
        }
    }
        
}

