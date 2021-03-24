//
//  FilterButtonCollectionCell.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-23.
//

import UIKit
import RxSwift
import RxDataSources

class FilterButtonCollectionCell: UICollectionViewCell {
    
    struct Data: IdentifiableType, Equatable {
        let placeType: PlaceType?
        var buttonTitle: String { placeType?.rawValue ?? "All" }
        var selected: Bool
        
        var identity: String { buttonTitle }
    }
    
    @IBOutlet weak var filterButton: UIButton!
    
    // rx
    private(set) var bag = DisposeBag()
    
    private let defaultBorderColor = UIColor.secondaryLabel.withAlphaComponent(0.25).cgColor
    private let selectedColor: UIColor = .systemPink
    
    func configure(for data: Data) {
        filterButton.setTitle(data.buttonTitle, for: [])
        filterButton.tintColor = data.selected ? selectedColor : .label
        filterButton.layer.borderColor = data.selected ? selectedColor.cgColor : defaultBorderColor
    }
    
    // MARK: - Lifecycles
    
    override func awakeFromNib() {
        filterButton.layer.cornerRadius = 5
        filterButton.layer.borderColor = defaultBorderColor
        filterButton.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bag = .init()
    }
    
}
