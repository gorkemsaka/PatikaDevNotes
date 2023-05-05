//
//  ViewController.swift
//  UITexfield
//
//  Created by Gorkem Saka on 5/4/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField:UITextField!
    @IBOutlet weak var passwordTextFiedl:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLoginButton ( _sender: UIButton){
        //Optional warningini susturmak icin, describing kullanarak textfieldden gelicek olan seyin String oldugunu tanimladik
        print("Username: \(String(describing: usernameTextField.text))")
        
        //Optional warningini susturmak icin, default bir value tanimladik.
        print("Password: \(passwordTextFiedl.text ?? "No Entry")")
       
        
    }
}

