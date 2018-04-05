//
//  MealTableViewController.swift
//  table_view_test
//
//  Created by nine on 05/04/18.
//  Copyright © 2018 nine. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    //MARK: Properties
    
    var meals = [Meal]() //empty array of meal objects, this is a mutable which u can add items to it after you intialize it
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMeals()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else{
            fatalError("The dequed cell is not an instance of MealTableViewCell")
        }
        
        let meal = meals[indexPath.row]
        // Configure the cell.
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }

    //MARK: Private Methods
    
    private func loadSampleMeals(){
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
    
        guard  let meal1 = Meal(name: "caprese 1", photo: photo1, rating: 4) else {
            fatalError("unable to initantiate meal")
        }
        
        guard  let meal2 = Meal(name: "caprese 2 ", photo: photo2, rating: 2) else {
            fatalError("unable to initantiate meal")
        }
        
        guard  let meal3 = Meal(name: "caprese 3", photo: photo3, rating: 5) else {
            fatalError("unable to initantiate meal")
        }
        
        meals += [meal1,meal2,meal3]
    }

}
