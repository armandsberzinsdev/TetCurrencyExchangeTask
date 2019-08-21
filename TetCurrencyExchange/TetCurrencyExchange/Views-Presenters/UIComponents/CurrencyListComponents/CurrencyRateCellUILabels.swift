//
//  CurrencyRateCellUILabels.swift
//  Tet Currency
//
//  Created by armands.berzins on 21/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

class CurrencyRateCellUILabels: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }

    func setupStyle() {
        self.font = UIFont.TetCurrencyAppFonts.mainFont(ofSize: 40)
    }
}
