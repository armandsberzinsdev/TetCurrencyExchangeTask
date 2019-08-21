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
        self.backgroundColor = #colorLiteral(red: 0.8831958175, green: 0.8831958175, blue: 0.8831958175, alpha: 1)
        self.layer.cornerRadius = 8
    }
    
}

