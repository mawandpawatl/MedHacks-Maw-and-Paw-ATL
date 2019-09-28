//
//  CreateWorkoutViewController.swift
//  Maw and Paw ATL
//
//  Created by Laurence Wingo on 9/27/19.
//  Copyright © 2019 Maw and Paw ATL, LLC. All rights reserved.
//

import UIKit

class CreateWorkoutViewController: UIViewController {
    
    @IBOutlet weak var workoutTimeLel: UILabel?
    @IBOutlet weak var workoutDistanceLel: UILabel?
    @IBOutlet weak var toggleWorkoutBton: UIButton?
    @IBOutlet weak var pauseWorkoutBton: UIButton?
    @IBOutlet weak var stopWorkoutBton: UIButton?
    
    @IBOutlet weak var workoutTimeLabel: UILabel!
    @IBOutlet weak var workoutDistanceLabel: UILabel!
    @IBOutlet weak var pauseWorkoutButton: UIImageView!
    @IBOutlet weak var stopWorkoutButton: UIImageView!
    @IBOutlet weak var toggleWorkoutButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func stopWorkout(_ sender: Any) {
    }
    
    @IBAction func toggleWorkout(){
        print("Play workout button pressed")
    }
    
    @IBAction func pauseWorkout(){
        print("Pause workout button pressed")
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
