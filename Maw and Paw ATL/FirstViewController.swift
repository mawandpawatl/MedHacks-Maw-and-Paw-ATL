//
//  FirstViewController.swift
//  Maw and Paw ATL
//
//  Created by Laurence Wingo on 9/19/19.
//  Copyright © 2019 Maw and Paw ATL, LLC. All rights reserved.
//

import UIKit

class CreateWorkoutViewController: UIViewController {

    @IBOutlet weak var designableView: DesignableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        let gradient = CAGradientLayer()
        
        //gradient.colors = [UIColor(red:0.58, green:0.16, blue:0.12, alpha:1.0).cgColor, UIColor(red:0.93, green:0.13, blue:0.23, alpha:1.0).cgColor]
        
        
        gradient.colors = [UIColor(red:168.00, green:255.00, blue:120.00, alpha:1.0).cgColor, UIColor(red:120.00, green:255.00, blue:214.00, alpha:1.0).cgColor]
        
        gradient.frame = view.bounds
        //designableView.frame = view.bounds
        
        gradient.locations = [0.0, 1.0]
        
        gradient.startPoint = CGPoint.init(x: 1.0, y: 1.0)
        
        gradient.endPoint = CGPoint.init(x: 0.0, y: 0.0)
        
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
    }


}

