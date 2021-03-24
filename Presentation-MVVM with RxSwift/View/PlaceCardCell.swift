//
//  PlaceCardCell.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-24.
//

import UIKit

class PlaceCardCell: UITableViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    
    private func configure(image: UIImage?, name: String?, type: String?, address: String?) {
        coverImageView.image = image
        nameLabel.text = name
        typeLabel.text = type
        addressLabel.text = address
    }
    
    func configure(for place: PlaceUi) {
        configure(image: place.image, name: place.name, type: place.type.rawValue, address: place.address)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.secondaryLabel.cgColor
        container.layer.cornerRadius = 12
    }



}
