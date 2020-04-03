//
//  Dose.swift
//  MisRecetas
//
//  Created by Alicia Ngomo Fernandez on 01/04/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift


class Dose: Object {
    @objc dynamic var measure : String = ""
    @objc dynamic var amount : String = ""
    @objc dynamic var ingredient : Ingredient?
    
}
