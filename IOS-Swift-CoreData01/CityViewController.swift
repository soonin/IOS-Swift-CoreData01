//
//  CityViewController.swift
//  IOS-Swift-CoreData01
//
//  Created by Pooya Hatami on 2018-03-15.
//  Copyright © 2018 Pooya Hatami. All rights reserved.
//

import UIKit
import CoreData

class CityViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableview: UITableView!
    var cityArray : [CityLib] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        fetchData()
        tableview.reloadData()
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cellname = cityArray[indexPath.row]
        cell.textLabel!.text = cellname.cityName! + " " + cellname.provinceName! + " " + cellname.countryName!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        if editingStyle == .delete {
            let city = cityArray[indexPath.row]
            context.delete(city)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
            do {
                cityArray = try context.fetch(CityLib.fetchRequest())
            } catch {
                print(error)
            }
        tableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            cityArray = try context.fetch(CityLib.fetchRequest())
        } catch {
            print(error)
        }
    }
    

}
