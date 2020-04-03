//
//  Item.swift
//  Todoey
//
//  Created by Alicia Ngomo Fernandez on 28/03/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift


class Ingredient: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var dose : Bool = false
    
    var parentReceta = LinkingObjects(fromType: Receta.self, property: "ingredients")
}
