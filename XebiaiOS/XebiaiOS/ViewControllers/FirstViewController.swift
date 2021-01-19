//
//  ViewController.swift
//  XebiaiOS
//
//  Created by Yagnyadatta Bairiganjan on 18/01/21.
//

import UIKit

class FirstViewController: UIViewController{
    let service = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.performSegue(withIdentifier: "movieVC", sender: nil)

        })
    }
}

