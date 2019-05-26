//
//  CountryCell.swift
//  Countries List App
//
//  Created by karim metawea on 5/26/19.
//  Copyright © 2019 KarimMetawea. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var CountryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backGroundView.layer.cornerRadius = 15
        backGroundView.layer.borderColor = UIColor.tintColor.cgColor
        backGroundView.layer.borderWidth = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(country:Country){
        CountryLabel.text = country.name
    }
    

}
