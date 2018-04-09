//
//  MealTableViewController.swift
//  table_view_test
//
//  Created by nine on 05/04/18.
//  Copyright © 2018 nine. All rights reserved.
//

import UIKit
import AFNetworking
import SDWebImage

class MealTableViewController: UITableViewController {
    //MARK: Properties
    
    //var meals = [Meal]() //empty array of meal objects, this is a mutable which u can add items to it after you intialize it
    var responses : NSArray = []

    @IBOutlet var mealTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // loadSampleMeals()
        getAsync()
        
    }
    
    
    func getAsync()  {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet.init(object: "application/json") as? Set<String>
        
        manager.get("https://homee-api.azurewebsites.net/feed/17557580/estate/541180", parameters: nil, progress: nil, success: {(URLSessionDataTask,responseObject ) in
            print(responseObject as! NSArray)
            let result = responseObject as! NSArray
            print(result.object(at: 0))
            let firstObject = result.object(at: 1) as! NSDictionary
            //let header = firstObject.value(forKey: "header") as! String
            print(firstObject.value(forKey: "date") ?? "0")
            
            // MARK: - Adding data to table view
            //Adding data to the table view
            self.responses = responseObject as! NSArray
            self.mealTableView.reloadData()
            
            
        }, failure: {(URLSessionDataTask , error) in
            print(error)
        })
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return responses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else{
            fatalError("The dequed cell is not an instance of MealTableViewCell")
        }
        
        let data = responses.object(at: indexPath.row) as! NSDictionary
        cell.nameLabel.text = String(data.value(forKey: "articleId") as! Int) // string( data as! int) means putting value as int and converting it to string
        let imageUrl = URL(string: data.value(forKey: "imageUrl") as! String) //converting string to url
        cell.photoImageView.sd_setImage(with: imageUrl)
        
//        let meal = meals[indexPath.row]
//        // Configure the cell.
//        cell.nameLabel.text = meal.name
//        cell.photoImageView.image = meal.photo
//        cell.ratingControl.rating = meal.rating
        
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
        
        //meals += [meal1,meal2,meal3]
    }

}
