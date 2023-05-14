//
//  ViewController.swift
//  NavigationControllerExample
//
//  Created by Gorkem Saka on 5/7/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapPorfileButton(_ sender : UIButton){
        
        // Navigation yapan fonksiyon
        //Identifier onemli, tam olarak anlayamadim ama, mainde soldaki ayarlarda,storyboardSegue kismindan ayarladim
        performSegue(withIdentifier: "Profile", sender: self)
    }
    
}

