//
//  ViewController.swift
//  Star Rating (Custom Control)
//
//  Created by Iyin Raphael on 1/8/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBAction func updateRating(_ sender: CustomControl) {
        let N = sender.value
        if N > 1 {
            self.title = "User Rating: \(N) stars"
        } else {
            self.title = "User Rating: \(N) star"
        }
        
        
    }
    
}

