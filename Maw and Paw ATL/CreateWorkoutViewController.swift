//
//  CreateWorkoutViewController.swift
//  Maw and Paw ATL
//
//  Created by Laurence Wingo on 9/27/19.
//  Copyright © 2019 Maw and Paw ATL, LLC. All rights reserved.
//

import UIKit
import CoreLocation
import SCLAlertView
import QuartzCore

enum WorkoutState {
    case inactive
    case active
    case pause
}

let timerInterval: TimeInterval = 1.0

class CreateWorkoutViewController: UIViewController {
    
    
    @IBOutlet weak var workoutTimeLabel: UILabel!
    @IBOutlet weak var workoutDistanceLabel: UILabel!
    @IBOutlet weak var pauseWorkoutButton: UIButton!
    @IBOutlet weak var toggleWorkoutButton: UIButton!
    @IBOutlet weak var stopWorkoutButton: UIButton!
    var currentWorkoutState = WorkoutState.inactive
    let locationManager = CLLocationManager()
    var lastSavedTime: Date?
    var workoutDuration: TimeInterval = 0.0
    var workoutTimer: Timer?
    var workoutDistance: Double = 0.0
    var lastSavedLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
    }
    
    
    @IBAction func stopWorkout(_ sender: Any) {
        print("Stop workout button pressed")
        currentWorkoutState = .inactive
        stopWorkoutTimer()
        updateUserInterface()
    }
    
    @IBAction func toggleWorkout(){
        print("Play workout button pressed")
        switch currentWorkoutState {
        case .inactive:
            currentWorkoutState = .active
            requestLocationPermission()
        case .active:
            currentWorkoutState = .inactive
            stopWorkoutTimer()
        case .pause:
            currentWorkoutState = .active
            resumeWorkoutTimer()
            
            
        }
        updateUserInterface()
    }
    
    func requestLocationPermission(){
        if CLLocationManager.locationServicesEnabled(){
            print("Location services are available")
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.distanceFilter = 9.0 //meters...or approximately 10 football yards
            locationManager.pausesLocationUpdatesAutomatically = true
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.delegate = self
            switch CLLocationManager.authorizationStatus(){
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse:
                requestAlwaysPermission()
            case .authorizedAlways:
                startWorkout()
            default:
                presentPermissionErrorAlert()
            }
        } else {
            presentEnableLocationAlert()
        }
    }
    
    func requestAlwaysPermission(){
        if let isConfigured = UserDefaults.standard.value(forKey: "isConfigured") as? Bool, isConfigured == true {
            startWorkout()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func startWorkout(){
        currentWorkoutState = .active
        UserDefaults.standard.setValue(true, forKey: "isConfigured")
        UserDefaults.standard.synchronize()
        workoutDuration = 0.0
        workoutTimer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(updateWorkoutData), userInfo: nil, repeats: true)
        locationManager.startUpdatingLocation()
    }
    
    @objc func updateWorkoutData(){
        let now = Date()
        if let lastTime = lastSavedTime {
            self.workoutDuration += now.timeIntervalSince(lastTime)
        }
        self.workoutDuration += timerInterval
        workoutTimeLabel.text = stringFromTime(timeInterval: self.workoutDuration)
        //workoutTimeLabel.text = String(self.workoutDuration)
        workoutDistanceLabel.text = String(format: "%.2f meters", arguments: [workoutDistance])
    }
    
    func stringFromTime(timeInterval: TimeInterval) -> String{
        let integerDuration = Int(timeInterval)
        let seconds = integerDuration % 60
        let minutes = (integerDuration / 60) % 60
        let hours = (integerDuration / 3600)
        //let fractionOfSeconds = Double((seconds * 1000)).truncatingRemainder(dividingBy: 0.60000)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        //let strFraction = String(format: "%02d", fractionOfSeconds)
        //print(fractionOfSeconds)
        
        
        if hours > 0 {
            return String("\(hours):\(strMinutes):\(strSeconds)")
        } else {
            return String("00:\(strMinutes):\(strSeconds)")
        }
    }
    
    func presentPermissionErrorAlert(){
        let alertView = SCLAlertView().showError("Uh Oh", subTitle: "Please enable location services for this app.")
        alertView.setDismissBlock {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
    }
    
    func presentEnableLocationAlert(){
        
        let alertView = SCLAlertView().showError("Uh Oh", subTitle: "Please enable location services on your device")
        alertView.setDismissBlock {
            print("done.")
        }
    }
    
    @objc func openLocationSettingsOnDevice(){
        print("openLocationSettingsOnDevice button tapped")
    }
    
    @IBAction func pauseWorkout(){
        print("Pause workout button pressed")
        
        
        switch currentWorkoutState {
        case .pause:
            startWorkout()
            updateUserInterface()
        case .active:
            currentWorkoutState = .pause
            stopWorkoutTimer()
            updateUserInterface()
        default:
            print("pauseWorkout() called out of context!")
        }
    }
    
    func stopWorkoutTimer(){
        workoutTimer?.invalidate()
        lastSavedTime = nil
    }
    
   
    
    func resumeWorkoutTimer(){
        lastSavedTime = nil
        workoutTimer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(updateWorkoutData), userInfo: nil, repeats: true)
    }
    
    func updateUserInterface(){
        switch currentWorkoutState {
        case .active:
            toggleWorkoutButton.isHidden = true
            pulsateButton(buttonToPulsate: pauseWorkoutButton)
            pulsateButton(buttonToPulsate: stopWorkoutButton)
        case .pause:
            toggleWorkoutButton.isHidden = false
            stopPulsateButton(buttonToPulsate: pauseWorkoutButton)
            stopPulsateButton(buttonToPulsate: stopWorkoutButton)
            pulsateButton(buttonToPulsate: toggleWorkoutButton)
        case .inactive:
            toggleWorkoutButton.isHidden = false
            pulsateButton(buttonToPulsate: toggleWorkoutButton)
            stopPulsateButton(buttonToPulsate: pauseWorkoutButton)
            stopPulsateButton(buttonToPulsate: stopWorkoutButton)
            
        }
    }
    
    func pulsateButton(buttonToPulsate: UIButton) {
        let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1.0
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = NSNumber(value: 1.2)
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        buttonToPulsate.layer.add(pulseAnimation, forKey: "layerAnimation")
    }
    
    func stopPulsateButton(buttonToPulsate: UIButton) {
        buttonToPulsate.layer.removeAllAnimations()
    }
    
}

extension CreateWorkoutViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Received permission change update!")
        switch status {
        case .authorizedWhenInUse:
            requestAlwaysPermission()
        case .authorizedAlways:
            startWorkout()
        case .denied:
            presentPermissionErrorAlert()
        default:
            print("Unhandled Location Manager Status: \(status)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            print("Unable to read most recent location")
            return
        }
        if let savedLocation = lastSavedLocation{
            let distanceDelta = savedLocation.distance(from: mostRecentLocation)
            workoutDistance += distanceDelta
        }
        lastSavedLocation = mostRecentLocation
        print("Most recent location: \(String.init(describing: mostRecentLocation))")
    }
}
