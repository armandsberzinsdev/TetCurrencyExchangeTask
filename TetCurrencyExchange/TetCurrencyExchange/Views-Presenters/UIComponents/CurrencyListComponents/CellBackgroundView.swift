//
//  CellBackgroundView.swift
//  Tet Currency
//
//  Created by armands.berzins on 21/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

class CellBackgroundView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func setupStyle() {
        /* Background color set from TableViewController CellForRowAtIndex  -
        self.backgroundColor = UIColor.TetColours.tetCurrencyRateBGColour
         */
        self.layer.cornerRadius = 8
    }
}

