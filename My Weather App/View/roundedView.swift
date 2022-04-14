//
//  roundedView.swift
//  My Weather App
//
//  Created by Youssef Bhl on 09/02/2022.
//

import UIKit

class roundedView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 15
        self.layer.shadowOpacity = 0.4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
}
