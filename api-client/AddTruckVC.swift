//
//  AddTruckVC.swift
//  api-client
//
//  Created by user on 30/09/2017.
//  Copyright © 2017 David Kennedy. All rights reserved.
//

import UIKit

class AddTruckVC: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var foodTypeField: UITextField!
    @IBOutlet weak var avgCostField: UITextField!
    @IBOutlet weak var latField: UITextField!
    @IBOutlet weak var longField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func backButtonTapped(sender: UIButton) {
        dismissViewController()
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        
        guard let name = nameField.text, nameField.text != "" else {
            showAlert(title: "Error", message: "Please enter a name")
            return
        }
        
        guard let foodType = foodTypeField.text, foodTypeField.text != "" else {
            showAlert(title: "Error", message: "Please enter a food type")
            return
        }
        
        guard let avgcost = Double(avgCostField.text!), avgCostField.text != "" else {
            showAlert(title: "Error", message: "Please enter an average cost")
            return
        }
        
        guard let latitude = Double(latField.text!), latField.text != "" else {
            showAlert(title: "Error", message: "Please enter a latitude")
            return
        }
        
        guard let longitude = Double(longField.text!), longField.text != "" else {
            showAlert(title: "Error", message: "Please enter and longitude")
            return
        }
        
        DataService.instance.addNewFoodTruck(name, foodtype: foodType, avgcost: avgcost, latitude: latitude, longitude: longitude, completion: {
            Success in
            
            if Success {
                print("we saved successfully")
                self.dismissViewController()
            } else {
                self.showAlert(title: "Error", message: "An error occcured saving the new food truck")
                print("we didnt save successfully")
            }
        
        })
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        
    }
    
    func dismissViewController() {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


