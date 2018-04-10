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

class MealTableViewController: UITableViewController{
    
    //MARK: Properties
    //var meals = [Meal]() //empty array of meal objects, this is a mutable which u can add items to it after you intialize it
    var responses : NSArray = []
    var tempResponse : NSMutableArray = []
    @IBOutlet var mealTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // loadSampleMeals()
        getAsync()
         //Initializing Notification received from rating controller to send index path and rating selected, index path of row is sent as tag to rating controller
        NotificationCenter.default.addObserver(self, selector: #selector(receive(_:)), name: "myNotification" as? NSNotification.Name, object: nil)
}
    
    //MARK:  NSNotification receive method
    @objc func receive(_ notification: Notification?) {
        if ((notification?.name)!.rawValue == "myNotification") {
            
            let myDictionary = notification?.object as? NSDictionary // setting the object recieved as nsdictionatry
            var predicate = NSPredicate(format: "name = \(myDictionary?.object(forKey: "id") as! String)")
            let filteredArray : NSArray = tempResponse.filtered(using: predicate) as NSArray
            //  print(filteredArray)
            let temp1: NSDictionary = filteredArray.object(at: 0) as! NSDictionary
            let temp = ["imageUrl":temp1.object(forKey: "imageUrl") as! String ,
                        "name":temp1.object(forKey: "name") as! Int,
                        "rating": myDictionary?.object(forKey: "rating") as! Int] as [String : Any]
            //  print(temp)
            //    filteredArray.setValue(myDictionary?.object(forKey: "rating") as! Int, forKey: "rating")
            //  print(filteredArray)
            //            let tempDict: NSMutableDictionary = tempResponse.object(at: myDictionary?.object(forKey: "indexpath") as! Int) as! NSMutableDictionary
            //            tempDict.setObject(myDictionary?.object(forKey: "rating") as! Int, forKey: "rating" as NSCopying)
            self.tempResponse.replaceObject(at: myDictionary?.object(forKey: "indexpath") as! Int , with: temp)
            print(tempResponse)
        }
    }
    
    func getAsync()  {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet.init(object: "application/json") as? Set<String>
        
        manager.get("https://homee-api.azurewebsites.net/feed/17557580/estate/541180", parameters: nil, progress: nil, success: {(URLSessionDataTask,responseObject ) in
            
            //sample to access the objects
            let result = responseObject as! NSArray
            let firstObject = result.object(at: 1) as! NSDictionary
            //let header = firstObject.value(forKey: "header") as! String
            // print(firstObject.value(forKey: "date") ?? "0")
            
            // MARK: - Settin only required Data to an array tempResponse
            self.responses = responseObject as! NSArray //Adding response object to empty NSArray
            for i in self.responses{
                let tempObject:NSDictionary = i as! NSDictionary //Adding each object in tempobject from responses array
                
                self.tempResponse.add(["imageUrl":tempObject.object(forKey: "imageUrl"), //Adding data to EmptyTemp nsmutable array
                                       "name":tempObject.object(forKey: "articleId"),
                                       "rating":0])
            }
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
        
        //MARK: Adding data to Tableview row
        let data = tempResponse.object(at: indexPath.row) as! NSDictionary
        cell.nameLabel.text = String(data.value(forKey: "name") as! Int) // string( data as! int) means putting value as int and converting it to string
        let imageUrl = URL(string: data.value(forKey: "imageUrl") as! String) //converting string to url
        cell.photoImageView.sd_setImage(with: imageUrl) //Image set using sdwebimages lib
        
        cell.ratingControl.tag = indexPath.row //Setting the tag
        cell.ratingControl.accessibilityHint = String(data.value(forKey: "name") as! Int)
        cell.ratingControl.rating=data.object(forKey: "rating") as! Int //setting rating from rating controller
       
        //OLD code for meal
        //        let meal = meals[indexPath.row]
        //        // Configure the cell.
        //        cell.nameLabel.text = meal".name
        //        cell.photoImageView.image = meal.photo
        //        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    //MARK:  Old cold
    //
    //    private func loadSampleMeals(){
    //        let photo1 = UIImage(named: "meal1")
    //        let photo2 = UIImage(named: "meal2")
    //        let photo3 = UIImage(named: "meal3")
    //
    //        guard  let meal1 = Meal(name: "caprese 1", photo: photo1, rating: 4) else {
    //            fatalError("unable to initantiate meal")
    //        }
    //
    //        guard  let meal2 = Meal(name: "caprese 2 ", photo: photo2, rating: 2) else {
    //            fatalError("unable to initantiate meal")
    //        }
    //
    //        guard  let meal3 = Meal(name: "caprese 3", photo: photo3, rating: 5) else {
    //            fatalError("unable to initantiate meal")
    //        }
    //
    //meals += [meal1,meal2,meal3]
}


