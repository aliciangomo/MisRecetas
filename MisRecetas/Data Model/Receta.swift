//
//  Category.swift
//  Todoey
//
//  Created by Alicia Ngomo Fernandez on 28/03/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Receta: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var link : String = ""
    @objc dynamic var image : String = ""
    @objc dynamic var instructions : String = ""
    
    let ingredients = List<Ingredient>()
}
