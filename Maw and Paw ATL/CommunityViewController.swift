//
//  CommunityViewController.swift
//  Maw and Paw ATL
//
//  Created by Laurence Wingo on 10/8/19.
//  Copyright © 2019 Maw and Paw ATL, LLC. All rights reserved.
//

import UIKit

class CommunityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func circularOverlayMask() -> UIImage {
        let bounds = self.view.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        let diameter = width
        let radius = diameter / 2
        let center = CGPoint.init(x: width / 2, y: height / 2)
        
        // Create the image context
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        
        // Create the bezier paths
        let clipPath = UIBezierPath(rect: bounds)
        let maskPath = UIBezierPath.init(ovalIn: CGRect.init(x: center.x - radius, y: center.y - radius, width: diameter, height: diameter))

        
        clipPath.append(maskPath)
        clipPath.usesEvenOddFillRule = true
        
        clipPath.addClip()
        UIColor(white: 0, alpha: 0.5).setFill()
        clipPath.fill()
     
        let finalImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        return finalImage
    }
    

    
}
