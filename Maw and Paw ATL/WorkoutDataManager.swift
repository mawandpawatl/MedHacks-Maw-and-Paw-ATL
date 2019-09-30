//
//  WorkoutDataManager.swift
//  Pods-Maw and Paw ATL
//
//  Created by Laurence Wingo on 9/30/19.
//

import Foundation



class WorkoutDataManager {
    
    static let sharedManager = WorkoutDataManager()
    
    
    
    
    private init() {
        print("Singleton initialized")
    }
}
