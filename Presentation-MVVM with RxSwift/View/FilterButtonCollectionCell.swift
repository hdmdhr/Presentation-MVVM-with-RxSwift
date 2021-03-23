//
//  FilterButtonCollectionCell.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-23.
//

import UIKit

class FilterButtonCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var filterButton: UIButton!
    
    
    override func awakeFromNib() {
        filterButton.layer.cornerRadius = 5
        filterButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        filterButton.layer.borderWidth = 1
    }
    
}
