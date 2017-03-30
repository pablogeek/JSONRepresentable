//
//  ViewController.swift
//  JSONRepresentable
//
//  Created by Pablo Martinez on 30/03/2017.
//  Copyright © 2017 PabloSoftware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let country: Country = Country(name: "Spain")
        let city: City = City(name: "Valencia", country: country)
        
        let json = city.toJSON()
        print(json.1 ?? "")
        
        // this is the data
        let data = json.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

