//
//  ViewController.swift
//  ActivityIndicator
//
//  Created by Gorkem Saka on 5/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var greetingsLabel : UILabel!
    @IBOutlet weak var warningLabel : UILabel!
    
    @IBOutlet weak var usernameTexField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var activityIndicatorView : UIActivityIndicatorView!
    
    

    @IBAction func didTapLoginButton (_ sender : UIButton){
        
        
        //eger kullanici adi gorkem degilse hata mesajini ac
        // eger sifre girilmediyse hata mesajini ac
        
        
         if usernameTexField.text == "gorkem", passwordTextField.isHidden {
            passwordTextField.isHidden = false
            warningLabel.isHidden = true
             
         }else if(usernameTexField.text != "gorkem"){
             warningLabel.text = "HATA: Kullanici Adi Yanlis"
             warningLabel.isHidden = false
         }else if !(passwordTextField.isHidden), passwordTextField.text == "12345"{
            activityIndicatorView.startAnimating()
             warningLabel.isHidden = true
         }else if(passwordTextField.text != "12345"){
             warningLabel.text = "HATA: Sifre Yanlis"
             warningLabel.isHidden = false
             activityIndicatorView.isHidden = true
         }
        
        
    }
    
    


}

