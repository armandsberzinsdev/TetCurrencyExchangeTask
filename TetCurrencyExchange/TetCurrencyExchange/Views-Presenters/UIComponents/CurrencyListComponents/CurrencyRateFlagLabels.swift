//
//  CurrencyRateFlagLabels.swift
//  Tet Currency
//
//  Created by armands.berzins on 22/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

class CurrencyRateFlagLabels: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
    
    func setupStyle() {
        self.font = UIFont.systemFont(ofSize: 40)
    }
}
