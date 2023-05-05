//
//  ViewController.swift
//  UIButtons
//
//  Created by Gorkem Saka on 5/4/23.
//

import UIKit

class ViewController: UIViewController {
    
    // Manual olarak olusturulmus bir outlet label yolu
    @IBOutlet weak var label : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        
        sender.tintColor = UIColor.green
        label.text = "Butona basildi, Hosgeldiniz"
        print("Buttona basildi")
    }
    
    
}

