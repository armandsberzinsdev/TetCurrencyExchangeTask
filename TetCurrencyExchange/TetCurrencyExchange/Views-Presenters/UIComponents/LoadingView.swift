//
//  LoadingView.swift
//  Tet Currency
//
//  Created by armands.berzins on 22/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addBlurView()
        self.addActivityIndicator()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBlurView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = UIScreen.main.bounds
        self.addSubview(blurredEffectView)
    }
    
    func addActivityIndicator() {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = self.center
        activityView.startAnimating()
        self.addSubview(activityView)
    }
    
}

