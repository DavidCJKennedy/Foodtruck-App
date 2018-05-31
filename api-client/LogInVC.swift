//
//  LogInVC.swift
//  api-client
//
//  Created by user on 30/09/2017.
//  Copyright © 2017 David Kennedy. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        guard let email = emailTextField.text,
            emailTextField.text != "", let pass = passwordTextField.text, passwordTextField.text != "" else {
                self.showAlert(title: "Error", message: "Please enter an email and password to continue")
                return
        }
        
        AuthService.instance.registerUser(username: email, password: pass, completion: { Success in
            if Success {
                AuthService.instance.logIn(username: email, password: pass, completion: { Success in
                    if Success {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        OperationQueue.main.addOperation {
                            self.showAlert(title: "Error", message: "Incorrect Password")
                        }
                    }
                
                })
            } else {
                OperationQueue.main.addOperation {
                    self.showAlert(title: "Error", message: "An unknown error occurred saving the account")
                }
            }
        })
    }
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
