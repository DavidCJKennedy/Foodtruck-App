//
//  FoodTruckReview.swift
//  api-client
//
//  Created by user on 27/09/2017.
//  Copyright © 2017 David Kennedy. All rights reserved.
//

import Foundation

struct FoodTruckReview {
    
    var id: String = ""
    var title: String = ""
    var text: String = ""
    
    static func parseReviewJsonData(data: Data) -> [FoodTruckReview] {
        var foodTruckReviews = [FoodTruckReview]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            //Parse JSON Data
            if let reviews = jsonResult as? [Dictionary<String, AnyObject>] {
                for review in reviews {
                    
                    var newReview = FoodTruckReview()
                    newReview.id = review["_id"] as! String
                    newReview.title = review["title"] as! String
                    newReview.text = review["text"] as! String
                    
                    foodTruckReviews.append(newReview)
                }
            }
        } catch let err {
            print(err)
        }
        return foodTruckReviews
    }
}
