//
//  Example.swift
//  JSONRepresentable
//
//  Created by Pablo Martinez on 30/03/2017.
//  Copyright © 2017 PabloSoftware. All rights reserved.
//

import Foundation


struct City: JSONSerializable {
    let name: String
    let country: Country
}

struct Country: JSONSerializable {
    let name: String
}
