//
//  LettersCell.swift
//  Countries List App
//
//  Created by karim metawea on 6/17/19.
//  Copyright © 2019 KarimMetawea. All rights reserved.
//

import UIKit

class LettersCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var letterLabel: UILabel!
    
    override func awakeFromNib() {
        view.layer.cornerRadius = 10
    }
    
    
}
