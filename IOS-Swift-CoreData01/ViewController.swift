//
//  ViewController.swift
//  IOS-Swift-CoreData01
//
//  Created by Pooya Hatami on 2018-03-15.
//  Copyright © 2018 Pooya Hatami. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var cityText: UITextField!
    
    @IBOutlet weak var provinceText: UITextField!
    
    @IBOutlet weak var countryText: UITextField!
    
    @IBOutlet weak var serachFor: UITextField!
    
    @IBOutlet weak var searchResult: UILabel!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func savebtn(_ sender: UIButton) {
        let cityName = self.cityText!.text
        let provinceName = self.provinceText!.text
        let countryName = self.countryText!.text
        
        //validate input values
        if ( cityName?.isEmpty)! {
            self.cityText.layer.borderColor = UIColor.red.cgColor
            return
        } else {
            self.cityText.layer.borderColor = UIColor.black.cgColor
        }
        
        if (provinceName?.isEmpty)! {
            self.provinceText.layer.borderColor = UIColor.red.cgColor
            return
        } else {
            self.provinceText.layer.borderColor = UIColor.black.cgColor
        }

        if ( countryName?.isEmpty)! {
            self.countryText.layer.borderColor = UIColor.red.cgColor
            return
        } else {
            self.countryText.layer.borderColor = UIColor.black.cgColor
        }

        let newCity = NSEntityDescription.insertNewObject(forEntityName: "CityLib", into: context)
        newCity.setValue(self.cityText!.text, forKey: "CityName")
        newCity.setValue(self.provinceText!.text, forKey: "ProvinceName")
        newCity.setValue(self.countryText!.text, forKey: "CountryName")

        do {
            try context.save()
            
            self.cityText!.text = ""
            self.provinceText!.text = ""
            self.countryText!.text = ""
            
        } catch {
            print(error)
        }
        
        
    }
    
    @IBAction func searchBtn(_ sender: UIButton) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CityLib")
        let searchString = self.serachFor?.text
        
        request.predicate = NSPredicate(format: "cityName CONTAINS[cd] %@", searchString!)
        var outputSRT = ""
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                for oneLine in result {
                    let oneCity = (oneLine as AnyObject).value(forKey: "cityName") as! String
                    let oneProvince = (oneLine as AnyObject).value(forKey: "provinceName") as! String
                    let oneCountry = (oneLine as AnyObject).value(forKey: "countryName") as! String

                    outputSRT += oneCity + " " + oneProvince + " " + oneCountry + "\n"
                }
            } else {
                outputSRT = "No match Found!"
            }
            self.searchResult?.text = outputSRT
        } catch {
            print(error)
        }
        
    }
    

}

