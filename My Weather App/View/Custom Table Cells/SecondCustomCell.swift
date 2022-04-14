//
//  SecondCustomCell.swift
//  My Weather App
//
//  Created by Youssef Bhl on 11/02/2022.
//

import UIKit

class SecondCustomCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier = "SecondCustomCell"
    var closeWeathers : [WeatherInfo] = []
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCollectionView()        
    }
}

extension SecondCustomCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !closeWeathers.isEmpty {
            return closeWeathers.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        if !closeWeathers.isEmpty {
            item.configure(closeWeathers[indexPath.item])
            return item
        }
        return item
    }
}
