//
//  CustomCollectionViewCell.swift
//  My Weather App
//
//  Created by Youssef Bhl on 11/02/2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconIMG: UIImageView!
    @IBOutlet weak var tempLBL: UILabel!
    @IBOutlet weak var minLBL: UILabel!
    @IBOutlet weak var maxLBL: UILabel!
    @IBOutlet weak var dateLBL: UILabel!
    
    
    static let identifier = "CustomCollectionViewCell"
    
    func configure (_ model : WeatherInfo) {
        ImageDownloader.shared.fromUrlString(model.weather[0].icon) { d in
            self.iconIMG.image = UIImage(data: d!)
        }
        self.tempLBL.text = String(format: "%0.f", model.main.temp) + "ºC"
        self.minLBL.text = "Min : \(model.main.temp_min)ºC"
        self.maxLBL.text = "Max : \(model.main.temp_max)ºC"
        var date = model.dt_txt
        for _ in 0...10{
            date.removeFirst()
        }
        date.removeLast()
        date.removeLast()
        date.removeLast()
        dateLBL.text = date
    }
    
    
}
