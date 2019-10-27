//
//  FetchDiningRestaurantsViewController.swift
//  Maw and Paw ATL
//
//  Created by Laurence Wingo on 10/26/19.
//  Copyright © 2019 Maw and Paw ATL, LLC. All rights reserved.
//

import UIKit
import MapKit

class FetchDiningRestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var currentGlucoseLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cuisineSegmentBar: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var arrayOfCellData = [CellData]()
    
    var glucoseScore = 120
    var glucoseActive = true
    func increaseLabel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if self.glucoseScore < 118 {
                self.currentGlucoseLabel.textColor = UIColor.red
            } else {
                self.currentGlucoseLabel.textColor = UIColor.green
            }
            if self.glucoseActive {
                self.glucoseScore -= 1
                self.currentGlucoseLabel.text = "Current Glucose: \(self.glucoseScore) mg/dL"
                self.increaseLabel()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        arrayOfCellData = [CellData.init(cell: 0, retaurantImage: UIImage.init(named: "carrabba-s-italian-grill-squarelogo"), restaurantName: "Carrabba's", restaurantMainDish: "Most Popular Dish: Le Carte' Peta", restaurantMainDishCalories: "Calories: 27180", glucoseCalculation: "After this meal: 178 mg/dL"), CellData.init(cell: 1, retaurantImage: UIImage.init(named: "millerUnion"), restaurantName: "Miller Union", restaurantMainDish: "Most Popular Dish: Seasonal Vegetable Plate", restaurantMainDishCalories: "Calories: 600", glucoseCalculation: "After this meal: 137 mg/dL"), CellData.init(cell: 2, retaurantImage: UIImage.init(named: "stapleHouse"), restaurantName: "Staple House", restaurantMainDish: "Grandma Lillian’s Potato Bread", restaurantMainDishCalories: "Calories: 1000", glucoseCalculation: "After this meal: 190 mg/dL"), CellData.init(cell: 3, retaurantImage: UIImage.init(named: "kimballHouse"), restaurantName: "Kimball House", restaurantMainDish: "Most Popular Dish: Lamb Loin", restaurantMainDishCalories: "Calories: 1800", glucoseCalculation: "After this meal: 170 mg/dL"), CellData.init(cell: 4, retaurantImage: UIImage.init(named: "tinyLous"), restaurantName: "Tiny Lou's", restaurantMainDish: "Most Popular Dish: Clermont Burger", restaurantMainDishCalories: "Calories: 354", glucoseCalculation: "After this meal: 90 mg/dL"), CellData.init(cell: 5, retaurantImage: UIImage.init(named: "rootBaking"), restaurantName: "Root Baking Co.", restaurantMainDish: "Most Popular Dish: Ham & Cheese Croissant Sandwich", restaurantMainDishCalories: "Calories: 600", glucoseCalculation: "After this meal: 160 mg/dL")]
        
        increaseLabel()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("NewDiningTableViewCell", owner: self, options: nil)?.first as! NewDiningTableViewCell
        cell.restaurantImage.image = arrayOfCellData[indexPath.row].retaurantImage
        cell.retaurantCompanyTitle.text = arrayOfCellData[indexPath.row].restaurantName
        cell.popularDishLabel.text = arrayOfCellData[indexPath.row].restaurantMainDish
        cell.dishCaloiresLabel.text = arrayOfCellData[indexPath.row].restaurantMainDishCalories
        cell.realtimeGlucoseLabel.text = arrayOfCellData[indexPath.row].glucoseCalculation
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
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
