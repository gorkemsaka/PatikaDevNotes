//
//  ViewController.swift
//  UILabel
//
//  Created by Gorkem Saka on 5/4/23.
//

import UIKit

class ViewController: UIViewController {

    // main'de, labelin uzerine control ile basili tutarak buraya surukleyince gelen kod.

    @IBOutlet weak var label: UILabel!
    
    // main'de, labelin uzerine control ile basili tutarak buraya surukleyince gelen kod.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.text = "Gorkem Saka"
        label.font = UIFont.systemFont(ofSize: 17.4)
        label.textColor = UIColor.secondaryLabel
        
    }


}

 
