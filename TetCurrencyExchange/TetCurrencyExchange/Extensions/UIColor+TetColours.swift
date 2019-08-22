//
//  UIColor+TetColours.swift
//  Tet Currency
//
//  Created by armands.berzins on 21/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//
import UIKit

extension UIColor {
    struct TetColours {
        static let tetMainColor = UIColor(red: 37/255, green: 90/255, blue: 245/255, alpha: 1.0) /* #255af5 */
        static let tetTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */
        static let tetCurrencyRateBGColour = UIColor(red: 0.8831958175, green: 0.8831958175, blue: 0.8831958175, alpha: 1.0)
        static let tetCurrencyRateInactiveTextColour = UIColor.black
        static let tetCurrencyRateHalfVisibleText = tetCurrencyRateInactiveTextColour.withAlphaComponent(0.5)
    }
}
