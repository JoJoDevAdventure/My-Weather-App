//
//  CellView.swift
//  My Weather App
//
//  Created by Youssef Bhl on 11/02/2022.
//

import UIKit

class CellView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.layer.borderColor = UIColor.systemGray3.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
    }

}
