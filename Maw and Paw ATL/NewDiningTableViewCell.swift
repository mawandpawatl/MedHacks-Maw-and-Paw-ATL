//
//  NewDiningTableViewCell.swift
//  Maw and Paw ATL
//
//  Created by Laurence Wingo on 10/26/19.
//  Copyright © 2019 Maw and Paw ATL, LLC. All rights reserved.
//

import UIKit

class NewDiningTableViewCell: UITableViewCell {

    @IBOutlet weak var orderUberEatsButton: UIButton!
    @IBOutlet weak var realtimeGlucoseLabel: UILabel!
    @IBOutlet weak var dishCaloiresLabel: UILabel!
    @IBOutlet weak var popularDishLabel: UILabel!
    @IBOutlet weak var retaurantCompanyTitle: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
