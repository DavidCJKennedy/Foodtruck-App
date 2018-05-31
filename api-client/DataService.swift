//
//  DataService.swift
//  api-client
//
//  Created by user on 27/09/2017.
//  Copyright © 2017 David Kennedy. All rights reserved.
//

import Foundation

protocol DataServiceDelegate: class {
    func trucksLoaded()
    func reviewsLoaded()
}

class DataService {
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    var foodTrucks = [FoodTruck]()
    var reviews = [FoodTruckReview]()
    
    // GET all food trucks 
    func getAllFoodTrucks() {
        let sessionConfig = URLSessionConfiguration.default
        
        // Create session, and optionally set a URLSessionDelegate
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        // Create the request
        // Get all foodtucks (GET /api/v1/foodtruck)
        guard let URL = URL(string: GET_ALL_FT_URL) else { return } //handle error
        var request  = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error == nil {
                //success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL session task suceeded \(statusCode)")
                if let data = data {
                    self.foodTrucks = FoodTruck.parseFoodTruckJSONData(data: data)
                    self.delegate?.trucksLoaded()
                }
            } else {
                // Failure
                print("URL session task failed: \(error!.localizedDescription)")
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    //GET all reviews for a specific Food Truck
    func getAllReviews(for truck: FoodTruck) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: "\(GET_ALL_FT_REVIEWS)/\(truck.id)") else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error == nil {
                //Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL session task suceeded: HTTP \(statusCode)")
                //PARSE data
                if let data = data {
                    self.reviews = FoodTruckReview.parseReviewJsonData(data: data)
                    self.delegate?.reviewsLoaded()
                }
            } else {
                //Failure
                print("URL session task failed: \(error!.localizedDescription)")
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    // POST add a new Food Truck
    func addNewFoodTruck(_ name: String, foodtype: String, avgcost: Double, latitude: Double, longitude: Double, completion: @escaping callback) {
        
        //Contruct our JSON
        let json: [String: Any] = [
            "name": name,
            "foodtype": foodtype,
            "avgcost": avgcost,
            "geometry" :[
                "coordinates" : [
                    "lat": latitude,
                    "long": longitude
                ]
            ]
        ]
        
        do {
            // serialise json
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let URL = URL(string: POST_ADD_NEW_TRUCK) else { return }
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
            guard let token = AuthService.instance.authToken else {
                completion(false)
                return
            }
            
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if error == nil {
                    //success check for status code 200 here. if not then auth was not successful. if it is, were done
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL session task succeeded: HTTP \(statusCode)")
                    if statusCode != 200 {
                        completion(false)
                        return
                    } else {
                        //added new one so return them all, return tableview
                        self.getAllFoodTrucks()
                        completion(true)
                    }
                } else {
                    //failure
                    print("URL session task failed: \(error!.localizedDescription)")
                    completion(false)
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
            
        } catch let err {
            completion(false)
            print(err)
        }
    }
    
    //POST add a new Food Truck Review
    func addNewReview(_ foodTruckId: String, title: String, text: String, completion: @escaping callback) {
        
        let json: [String: Any] = [
            "title": title,
            "text": text,
            "foodtruck": foodTruckId
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let URL = URL(string: "\(POST_ADD_NEW_REVIEW)/\(foodTruckId)") else {return}
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
            
            guard let token = AuthService.instance.authToken else {
                completion(false)
                return
            }
            
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if error == nil {
                    //success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL session task succeeded: HTTP \(statusCode)")
                    if statusCode != 200 {
                        completion(false)
                        return
                    } else {
                        completion(true)
                    }
                } else {
                    //Failure
                    print("URL session failed: \(error!.localizedDescription)")
                    completion(false)
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
            
        } catch let err {
            print(err)
            completion(false)
        }
    }
}
