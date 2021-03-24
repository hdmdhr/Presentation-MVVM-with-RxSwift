//
//  FilterButtonCollectionCell.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-23.
//

import UIKit
import RxDataSources

class FilterButtonCollectionCell: UICollectionViewCell {
    
    struct Data: IdentifiableType, Equatable {
        let placeType: PlaceType?
        var buttonTitle: String { placeType?.rawValue ?? "All" }
        var selected: Bool
        
        var identity: String { buttonTitle }
    }
    
    @IBOutlet weak var filterButton: UIButton!
    
    private let defaultBorderColor = UIColor.secondaryLabel.withAlphaComponent(0.25).cgColor
    private let selectedColor: UIColor = .systemPink
    
    func configure(for data: Data) {
        filterButton.setTitle(data.buttonTitle, for: [])
        filterButton.tintColor = data.selected ? selectedColor : .label
        filterButton.layer.borderColor = data.selected ? selectedColor.cgColor : defaultBorderColor
    }
    
    override func awakeFromNib() {
        filterButton.layer.cornerRadius = 5
        filterButton.layer.borderColor = defaultBorderColor
        filterButton.layer.borderWidth = 1
    }
    
}
