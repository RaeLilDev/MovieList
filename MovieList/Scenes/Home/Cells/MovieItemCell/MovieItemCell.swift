//
//  MovieItemCell.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import UIKit

class MovieItemCell: UITableViewCell {

    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDurationGenre: UILabel!
    @IBOutlet weak var lblWishlist: UILabel!
    @IBOutlet weak var containerImage: UIView!
    
    var data: MovieRO? {
        didSet {
            if let data = data {
                ivCover.image = UIImage(named: data.photo ?? "")
                lblTitle.text = "\(data.title ?? "") (\((data.releaseDate ?? Date()).toString(format: .type2)))"
                lblDurationGenre.text = "\(data.duration ?? "") - \(data.genre ?? "")"
                lblWishlist.isHidden = !(data.isSaved ?? false)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        ivCover.layer.cornerRadius = 8.0
        containerImage.layer.cornerRadius = 8.0
        containerImage.dropShadow(opacity: 0.05, radius: 4, width: 0, height: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
