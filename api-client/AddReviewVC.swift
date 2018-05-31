//
//  AddReviewVC.swift
//  api-client
//
//  Created by user on 01/10/2017.
//  Copyright © 2017 David Kennedy. All rights reserved.
//

import UIKit

class AddReviewVC: UIViewController {
    
    var selectedFoodTruck: FoodTruck?

    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var reviewTitleLabel: UITextField!
    
    @IBOutlet weak var reviewTextField: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let truck = selectedFoodTruck {
            headerLabel.text = truck.name
        } else {
            headerLabel.text = "Error"
        }
    }
    
    func dismissViewController() {
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Error", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let truck = selectedFoodTruck else {
            showAlert(title: "Error", message: "Could not get selected truck")
            return
        }
        
        guard let title = reviewTitleLabel.text, reviewTitleLabel.text != "" else {
            showAlert(title: "Error", message: "Please enter a title for your review")
            return
        }
        
        guard let reviewText = reviewTextField.text, reviewTextField.text != "" else {
            showAlert(title: "Error", message: "Please enter some text for your review")
            return
        }
        
        DataService.instance.addNewReview(truck.id, title: title, text: reviewText, completion: {
            Success in
            if Success {
                print("We saved successfully")
                DataService.instance.getAllReviews(for: truck)
                self.dismissViewController()
            } else {
                self.showAlert(title: "Error", message: "an error occured saving new review")
                print("unsuccessful save")
            }
        
        })

    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismissViewController()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismissViewController()
    }
    
}
